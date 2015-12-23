using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Models.Basket;
using Laceshop.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Merchello.Core.Sales;
using Merchello.Plugin.Payments.Braintree;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers.Checkout
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
            var paymentMethods = MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods()
                .Select(x => new SelectListItem()
                {
                    Value = x.PaymentMethod.Key.ToString(),
                    Text = x.PaymentMethod.Name
                });
            vm.PaymentMethods = new SelectList(paymentMethods, "Value", "Text");

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
        private void AuthorizeCreditCard(string paymentName, Address address)
        {

            //ProcessorArgumentCollection paymentArgs = null;
            // if (paymentMethod.Name == AppConstants.CreditCardPaymentMethodName)
            // paymentArgs = new ProcessorArgumentCollection
            //        {
            //            { "cardholderName", preparation.GetBillToAddress().Name },
            //            { "cardNumber", vm.CardDetail.Number },
            //            { "expireMonth", vm.CardDetail.ExpiryMonth.ToString() },
            //            { "expireYear", vm.CardDetail.ExpiryYear.ToString() },
            //            { "cardCode", vm.CardDetail.CVV }
            //        };

            //    }


            //    // Redirect to receipt page having saved invoice key in session
            //    if (attempt.Payment.Success)
            //    {
            //        Session["InvoiceKey"] = attempt.Invoice.Key.ToString();
            //        return RedirectToUmbracoPage(GetReceiptPageNode().Id);
            //    }
            //    else
            //    {
            //        ModelState.AddModelError(string.Empty, "Card authorisation failed: " + ParseError(attempt.Payment.Exception.Message));
            //    }
        }
        #endregion
    }
}