﻿using System;
using System.Web.Mvc;
using Laceshop.Models.Checkout;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core.Gateways;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Merchello.Core.Sales;
using Merchello.Plugin.Payments.Braintree;
using Umbraco.Web.Mvc;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout.BraintreePayment
{
	[GatewayMethodUi("BrainTree.StandardTransaction")]
	[PluginController("Bazaar")]
	public class BraintreeStandardTransactionController : BraintreeTransactionControllerBase
	{
		/// <summary>
		/// Responsible for rendering the payment form for capturing standard payments via Braintree.
		/// </summary>
		/// <returns>
		/// The <see cref="ActionResult"/> Partial View.
		/// </returns>
		[ChildActionOnly]
		public ActionResult RenderForm(PaymentPageViewModel model)
		{
			return PartialView("BraintreeStandardTransaction", model);
			return this.PartialView(BraintreePartial("BraintreeStandardTransaction"), model);
		}

		/// <summary>
		/// Responsible for actually processing the payment with the PaymentProvider
		/// </summary>
		/// <param name="preparation">
		/// The preparation.
		/// </param>
		/// <param name="paymentMethod">
		/// The payment method.
		/// </param>
		/// <returns>
		/// The <see cref="IPaymentResult"/>.
		/// </returns>
		protected IPaymentResult PerformProcessPayment(SalePreparationBase preparation, IPaymentMethod paymentMethod)
		{
			// ----------------------------------------------------------------------------
			// WE NEED TO GET THE PAYMENT METHOD "NONCE" FOR BRAINTREE

			var form = UmbracoContext.HttpContext.Request.Form;
			var paymentMethodNonce = form.Get("payment_method_nonce");

			// ----------------------------------------------------------------------------

			return this.ProcessPayment(preparation, paymentMethod, paymentMethodNonce);
		}

		// AuthorizeCapturePayment will save the invoice with an Invoice Number.
		private IPaymentResult ProcessPayment(SalePreparationBase preparation, IPaymentMethod paymentMethod, string paymentMethodNonce)
		{
			// You need a ProcessorArgumentCollection for this transaction to store the payment method nonce
			// The braintree package includes an extension method off of the ProcessorArgumentCollection - SetPaymentMethodNonce([nonce]);
			var args = new ProcessorArgumentCollection();
			args.SetPaymentMethodNonce(paymentMethodNonce);

			// We will want this to be an AuthorizeCapture(paymentMethod.Key, args);
			return preparation.AuthorizeCapturePayment(paymentMethod.Key, args);
		}

		public BraintreeStandardTransactionController()
		{
		}

		public override ActionResult RenderForm(CardDetailViewModel model)
		{
			throw new NotImplementedException();
		}
	}
}