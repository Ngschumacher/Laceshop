using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Controllers;
using Laceshop.Models.Basket;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Merchello.Core.Sales;
using Merchello.Plugin.Payments.Braintree;
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
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            var vm = GetPageModel<PaymentPageViewModel>();
            vm.Basket = AutoMapper.Mapper.Map<BasketViewModel>(basket);
            vm.Basket.AllowBasketEdit = false;
            vm.Basket.ShowOrderTotal = true;

			var invoice = _basketRepository.PrepareInvoice();
			var shipmentLineItem = invoice.ShippingLineItems().FirstOrDefault();

            var paymentMethods = MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods()
                .Select(x => new SelectListItem()
                {
                    Value = x.PaymentMethod.Key.ToString(),
                    Text = x.PaymentMethod.Name
                });
            var rand = new Random();
            vm.PaymentMethods = new SelectList(paymentMethods, "Value", "Text");
            var quickPayModel = new QuickPayModel()
            {
                AgreementId = "44267",
                Amount = "1000",
                CallbackUrl = "http://laceshop.localhost//MerchelloQuickPay/Callback",
                CancelUrl = "http://laceshop.localhost/payment/",
                ContinueUrl = "http://laceshop.localhost/receipt/",
                Currency = "DKK",
                MerchantId = "12616",
                OrderId = "test1231"+rand.Next(0,1500)
            };
            quickPayModel.Checksum = GetChecksum(quickPayModel);
            vm.QuickPayModel = quickPayModel;
            return CurrentTemplate(vm);
        }

        /// <summary>
        /// Handles the select payment form post
        /// </summary>
        /// <param name="vm">Payment form model</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SelectPayment(PaymentPageViewModel vm)
        {
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            if (ModelState.IsValid)
            {
                // Associate the payment method with the order
                var paymentMethod = MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethodByKey(vm.SelectedPaymentMethod).PaymentMethod;
                var preparation = _basketRepository.SalePreparation();
                _basketRepository.SavePaymentMethod(paymentMethod);
                // Authorise the payment - if by card, need to collect the card details
				//var attempt = preparation.AuthorizePayment(paymentMethod.Key);
				var attempt = this.PerformProcessPayment(preparation, paymentMethod);

                // Redirect to receipt page having saved invoice key in session
                if (attempt.Payment.Success)
                {
                    Session["InvoiceKey"] = attempt.Invoice.Key.ToString();
                    return RedirectToUmbracoPage(GetReceiptPageNode().Id);
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Card authorisation failed: " + attempt.Payment.Exception.Message);
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