using System;
using System.Web.Mvc;
using Laceshop.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Models;
using Merchello.Plugin.Payments.Braintree;
using Merchello.Plugin.Payments.Braintree.Provider;
using Merchello.Plugin.Payments.Braintree.Services;
using Merchello.Web.Mvc;

namespace Laceshop.Website.Code.Controllers.Checkout.BraintreePayment
{
	public abstract class BraintreeTransactionControllerBase : PaymentMethodUiController<CardDetailViewModel>
	{
		/// <summary>
		/// The view path.
		/// </summary>
		private const string ViewPath = "~/App_Plugins/Merchello.Braintree/Views/Partials/";

		/// <summary>
		/// The <see cref="IBraintreeApiService"/>
		/// </summary>
		private readonly IBraintreeApiService _service;

		/// <summary>
		/// Initializes a new instance of the <see cref="BraintreeTransactionControllerBase"/> class.
		/// </summary>
		

		[ChildActionOnly]
		public ActionResult RenderBraintreeSetupJs()
		{

            var token = CurrentCustomer.IsAnonymous ?
            _service.Customer.GenerateClientRequestToken() :
            _service.Customer.GenerateClientRequestToken((ICustomer)CurrentCustomer);

			//var token = _service.Customer.GenerateClientRequestToken();

			return PartialView("BraintreeSetupJs", new BraintreeToken() { Token = token });
		}


		/// <summary>
		/// Helper method to construct the path to the MVC Partial view for this plugin.
		/// </summary>
		/// <param name="viewName">
		/// The view name.
		/// </param>
		/// <returns>
		/// The virtual path to the partial view.
		/// </returns>
		protected string BraintreePartial(string viewName)
		{
			viewName = viewName.EndsWith(".cshtml") ? viewName : viewName + ".cshtml";
			return string.Format("{0}{1}", ViewPath, viewName);
		}

		protected BraintreeTransactionControllerBase()
		{
			//// D143E0F6-98BB-4E0A-8B8C-CE9AD91B0969 is the Guid from the BraintreeProvider Activation Attribute
			//// [GatewayProviderActivation("D143E0F6-98BB-4E0A-8B8C-CE9AD91B0969", "BrainTree Payment Provider", "BrainTree Payment Provider")]
			var provider = (BraintreePaymentGatewayProvider)MerchelloContext.Current.Gateways.Payment.GetProviderByKey(new Guid("D143E0F6-98BB-4E0A-8B8C-CE9AD91B0969"));

			// GetBraintreeProviderSettings() is an extension method with the provider
			_service = new BraintreeApiService(provider.ExtendedData.GetBrainTreeProviderSettings());
		}
	}
}