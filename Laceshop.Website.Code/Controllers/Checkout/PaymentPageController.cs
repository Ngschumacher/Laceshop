using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Merchello.Core.Sales;
using Merchello.Plugin.Payments.Braintree;
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
            vm.Basket = AutoMapper.Mapper.Map<BasketViewModel>(Basket);
            vm.Basket.AllowBasketEdit = false;
            vm.Basket.ShowOrderTotal = true;
            var basketReadyForInvoice = _paymentManager.IsReadyToInvoice();
            if (!basketReadyForInvoice)
            {
                return RedirectToUmbracoPage(GetBasketPageNode().Id);
            }
            
            var invoice = _paymentManager.PrepareInvoice();
            var order = invoice.PrepareOrder();
			var shipmentLineItem = invoice.ShippingLineItems().FirstOrDefault();
            var number = order.OrderNumber;
            var paymentMethods = MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods()
                .Select(x => new SelectListItem()
                {
                    Value = x.PaymentMethod.Key.ToString(),
                    Text = x.PaymentMethod.Name
                });
            
            vm.PaymentMethods = new SelectList(paymentMethods, "Value", "Text");

            vm.QuickPayModel = GetQuickPayModel(invoice);
            return CurrentTemplate(vm);
        }
        
        private QuickPayModel GetQuickPayModel(IInvoice invoice)
        {
            var quickPayModel = new QuickPayModel()
            {
                AgreementId = "44267",
                Amount = invoice.Total.ToString(),
                CallbackUrl = "http://laceshop.localhost:80/customCallback/callback",
                CancelUrl = "http://laceshop.localhost:80/payment/",
                ContinueUrl = "http://laceshop.localhost:80/receipt?id=" + invoice.InvoiceNumber,
                Currency = invoice.CurrencyCode(),
                MerchantId = "12616",
                OrderId = invoice.InvoiceNumber.ToString(),
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

        private static string ParseError(string exceptionMessage)
        {
            return exceptionMessage.Split('|')[3];
        }
		protected IPaymentResult PerformProcessPayment(SalePreparationBase preparation, IPaymentMethod paymentMethod)
		{
			// ----------------------------------------------------------------------------
			// WE NEED TO GET THE PAYMENT METHOD "NONCE" FOR BRAINTREE

			var form = UmbracoContext.HttpContext.Request.Form;
			var paymentMethodNonce = form.Get("payment_method_nonce");

			// ----------------------------------------------------------------------------

			return this.ProcessPayment(preparation, paymentMethod, paymentMethodNonce);
		}
		private IPaymentResult ProcessPayment(SalePreparationBase preparation, IPaymentMethod paymentMethod, string paymentMethodNonce)
		{
			// You need a ProcessorArgumentCollection for this transaction to store the payment method nonce
			// The braintree package includes an extension method off of the ProcessorArgumentCollection - SetPaymentMethodNonce([nonce]);
			var args = new ProcessorArgumentCollection();
			args.SetPaymentMethodNonce(paymentMethodNonce);

			// We will want this to be an AuthorizeCapture(paymentMethod.Key, args);
			return preparation.AuthorizeCapturePayment(paymentMethod.Key, args);
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