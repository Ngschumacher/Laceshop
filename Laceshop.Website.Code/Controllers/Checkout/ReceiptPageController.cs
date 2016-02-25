using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Controllers;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Umbraco.Core.Logging;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class ReceiptPageController : BaseSurfaceController<ReceiptPageViewModel>
    {
        #region Constructor
        private readonly IBasketRepository _basketRepository;
        public ReceiptPageController(IUmbracoMapper mapper, IBasketRepository basketRepository)
            : base(mapper)
        {
            _basketRepository = basketRepository;
        }

        #endregion

        #region Action Methods

        /// <summary>
        /// Renders the receipt page
        /// </summary>
        /// <returns></returns>
        public ActionResult ReceiptPage()
        {
            var preparation = _basketRepository.SalePreparation();
            var invoice = preparation.PrepareInvoice();
            var order  = invoice.PrepareOrder();
            
            var quickPay = GetQuickPayModel(invoice);
            // Authorise the payment - if by card, need to collect the card details

            IInvoice byInvoiceNumber = MerchelloContext.Current.Services.InvoiceService.GetByInvoiceNumber(int.Parse(quickPay.RealOrderId));
            IPaymentGatewayMethod paymentGatewayMethod1 = MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods().SingleOrDefault(x => x.PaymentMethod.ProviderKey == Guid.Parse(Constants.ProviderId));
            if (paymentGatewayMethod1 == null)
            {
                StringBuilder stringBuilder = new StringBuilder();
                stringBuilder.AppendLine(string.Format("QuickPay PaymentGatewayMethod not found. Looked for provider with key {0}", (object)Constants.ProviderId));
                stringBuilder.AppendLine("Here is a list of the payment providers found:");
                foreach (IPaymentGatewayMethod paymentGatewayMethod2 in MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods())
                    stringBuilder.AppendLine(string.Format("Name: {0}, PaymentCode: {1}, Key: {2}, ProviderKey: {3}", (object)paymentGatewayMethod2.PaymentMethod.Name, (object)paymentGatewayMethod2.PaymentMethod.PaymentCode, (object)paymentGatewayMethod2.PaymentMethod.Key, (object)paymentGatewayMethod2.PaymentMethod.ProviderKey));
                LogHelper.Warn<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>(stringBuilder.ToString());
            }
            ProcessorArgumentCollection args = new ProcessorArgumentCollection();
            args.Add(Constants.ExtendedDataKeys.PaymentCurrency, quickPay.Currency);
            args.Add(Constants.ExtendedDataKeys.PaymentAmount, quickPay.Amount);
            args.Add(Constants.ExtendedDataKeys.QuickpayPaymentId, quickPay.OrderId);
            Notification.Trigger("OrderConfirmation", byInvoiceNumber.AuthorizePayment(paymentGatewayMethod1, args), new string[1]
            {
                byInvoiceNumber.BillToEmail
            });

            var vm = GetPageModel<ReceiptPageViewModel>();
            return CurrentTemplate(vm);
        }
        private QuickPayModel GetQuickPayModel(IInvoice invoice)
        {
            var rand = new Random();
            var orderId = rand.Next(0, 1345).ToString();
            var quickPayModel = new QuickPayModel()
            {
                AgreementId = "44267",
                Amount = invoice.Total.ToString(),
                CallbackUrl = "http://laceshop.localhost:80/customCallback/callback",
                CancelUrl = "http://laceshop.localhost:80/payment/",
                ContinueUrl = "http://laceshop.localhost:80/payment?id=" + orderId,
                Currency = invoice.CurrencyCode(),
                MerchantId = "12616",
                OrderId = orderId,
                RealOrderId = invoice.InvoiceNumber.ToString()
            };
            quickPayModel.Checksum = GetChecksum(quickPayModel);
            return quickPayModel;
        }
         public string GetChecksum(QuickPayModel model)
        {
            var parameters = new Dictionary<string, string>
      {
        {"version", "v10"},
        {"merchant_id", model.MerchantId},
        {"agreement_id", model.AgreementId},
        {"order_id", model.OrderId},
        {"amount", model.Amount},
        {"currency", model.Currency},
        {"continueurl", model.ContinueUrl},
        {"cancelurl", model.CancelUrl},
        {"callbackurl", model.CallbackUrl},
        {"language", "en"},
        {"autocapture", "0"}
      };
            var checksum = Sign(parameters, "291d6733fd3127afc3f40dde477276815564158189b7404e3181e02f7e1ced13"); // QuickPay Payment Window API Key
            return checksum;
        }

        private string Sign(Dictionary<string, string> parameters, string apiKey)
        {
            var result = String.Join(" ", parameters.OrderBy(c => c.Key).Select(c => c.Value).ToArray());
            var e = Encoding.UTF8;
            var hmac = new HMACSHA256(e.GetBytes(apiKey));
            byte[] b = hmac.ComputeHash(e.GetBytes(result));
            var s = new StringBuilder();
            for (int i = 0; i < b.Length; i++)
            {
                s.Append(b[i].ToString("x2"));
            }
            return s.ToString();
        }

        #endregion
    }
}