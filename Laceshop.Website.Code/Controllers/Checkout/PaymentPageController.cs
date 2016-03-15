using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Laceshop.Website.Code.Models.Order;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Merchello.Core.Sales;
using Umbraco.Core.Logging;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class PaymentPageController : BaseSurfaceController<PaymentPageViewModel>
    {
        private readonly IBasketRepository _basketRepository;

        #region Constructor

        public PaymentPageController(IUmbracoMapper mapper, IBasketRepository basketRepository)
            : base(mapper)
        {
            _basketRepository = basketRepository;
        }

        #endregion

        #region Action Methods

        /// <summary>
        /// Renders the payment page
        /// </summary>
        /// <returns></returns>
        public ActionResult PaymentPage()
        {
           
            if (Basket.IsEmpty)
            {
                return RedirectToBasketPage();
            }

            var vm = GetPageModel<PaymentPageViewModel>();
           
            var basketReadyForInvoice = _paymentManager.IsReadyToInvoice();
            if (!basketReadyForInvoice)
            {
                return RedirectToUmbracoPage(GetBasketPageNode().Id);
            }
            var invoice = _paymentManager.PrepareInvoice();
            vm.Order = AutoMapper.Mapper.Map<OrderViewModel>(invoice);
            var order = invoice.PrepareOrder();
            
			var shipmentLineItem = invoice.ShippingLineItems().FirstOrDefault();
            var orderShippingItems = order.ShippingLineItems().FirstOrDefault();
            var totalTax = invoice.TotalTax();
            var produtItems = invoice.ProductLineItems();
            var shippingPrice = invoice.TotalShipping();
            var totalPrice = invoice.Total;
            var number = order.OrderNumber;

            vm.QuickPayModel = GetQuickPayModel(invoice);
            return CurrentTemplate(vm);
        }
        
        private QuickPayModel GetQuickPayModel(IInvoice invoice)
        {
            var quickPayModel = new QuickPayModel()
            {
                AgreementId = "44267",
                Amount = ((int)invoice.Total*100 ).ToString(CultureInfo.InvariantCulture),
                CallbackUrl = "http://laceshop.localhost:80/QuickPayCallback/Callback",
                CancelUrl = "http://laceshop.localhost:80/payment/",
                ContinueUrl = "http://laceshop.localhost:80/receipt?id=" + invoice.InvoiceNumber,
                Currency = invoice.CurrencyCode(),
                MerchantId = "12616",
                OrderId = invoice.InvoiceNumber.ToString(),
                Version = "v10",
                Language = "da",
                AutoCapture = "0"
            };
            quickPayModel.Checksum = GetChecksum(quickPayModel);
            return quickPayModel;
        }

        /// <summary>
        /// Handles the select payment form post
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        /// 
        public ActionResult asddd(string id)
        {
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            if (ModelState.IsValid)
            {
                // Associate the payment method with the order
                var preparation = _basketRepository.SalePreparation();
                var invoice  = preparation.PrepareInvoice();
                var quickpayModel = GetQuickPayModel(invoice);
                // Authorise the payment - if by card, need to collect the card details
				//var attempt = preparation.AuthorizePayment(paymentMethod.Key);
				//var attempt = this.PerformProcessPayment(preparation, paymentMethod);
                var attempt = ProcessQuickpayPayment(quickpayModel);
                // Redirect to receipt page having saved invoice key in session
                if (attempt)
                {
                    Session["InvoiceKey"] = invoice.Key.ToString();
                    return RedirectToUmbracoPage(GetReceiptPageNode().Id);
                }
                else
                {
                    //ModelState.AddModelError(string.Empty, "Card authorisation failed: " + attempt.Payment.Exception.Message);
                    throw new Exception();
                }
            }

            return CurrentUmbracoPage();
        }

     
        private bool ProcessQuickpayPayment(QuickPayModel quickPay)
        {

            IInvoice byInvoiceNumber = MerchelloContext.Current.Services.InvoiceService.GetByInvoiceNumber(int.Parse(quickPay.OrderId));
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
            return true;
        }

        public string GetChecksum(QuickPayModel model)
        {
            var parameters = new Dictionary<string, string>
      {
        {"version", model.Version},
        {"merchant_id", model.MerchantId},
        {"agreement_id", model.AgreementId},
        {"order_id", model.OrderId},
        {"amount", model.Amount},
        {"currency", model.Currency},
        {"continueurl", model.ContinueUrl},
        {"cancelurl", model.CancelUrl},
        {"callbackurl", model.CallbackUrl},
        {"language", model.Language},
        {"autocapture", model.AutoCapture}
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