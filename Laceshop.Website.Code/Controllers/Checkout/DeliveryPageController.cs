using System.Linq;
using System.Web.Mvc;
using Core.Interfaces;
using Core.Interfaces.Basket;
using Laceshop.Controllers;
using Laceshop.Models.Basket;
using Laceshop.Models.Checkout;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core.Models;
using Merchello.Core.Services;
using Zone.UmbracoMapper;
using Merchello.Core;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class DeliveryPageController : BaseSurfaceController<DeliveryPageViewModel>
    {
        private readonly IBasketRepository _basketRepository;
	    private readonly ShopHelper _shopHelper;
	    private readonly IStoreSettings _storeSettings;
	    private readonly ICurrency _currency;

	    public DeliveryPageController(IUmbracoMapper mapper, IBasketRepository basketRepository,ShopHelper shopHelper, IStoreSettings storeSettings ) : base(mapper)
	    {
		    _basketRepository = basketRepository;
		    _shopHelper = shopHelper;
		    _storeSettings = storeSettings;
	    }

	    public ActionResult DeliveryPage()
        {
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            // Package into shipments (we'll only have one)
            var shipment = _basketRepository.GetPackageBasket().First();
            var vm = GetPageModel<DeliveryPageViewModel>();
            vm.AllowBasketEdit = false;
            vm.ShowOrderTotal = true;
		    var invoice = _basketRepository.PrepareInvoice();
			var shipmentLineItem = invoice.ShippingLineItems().FirstOrDefault();


            vm.Basket = AutoMapper.Mapper.Map<BasketViewModel>(basket);
            vm.Basket.ShowOrderTotal = true;
            var deliveryOptions = shipment.ShipmentRateQuotes()
                .OrderBy(x => x.Rate)
                .Select(x => new SelectListItem()
                {
                    Value = x.ShipMethod.Key.ToString(),
					Text = string.Format("{0} ({1})", x.ShipMethod.Name, _shopHelper.FormatPrice(x.Rate))
                });
            vm.DeliveryOptions = new SelectList(deliveryOptions, "Value", "Text");
             
            return CurrentTemplate(vm);
        }

        /// <summary>
        /// Handles the select delivery optiom form post
        /// </summary>
        /// <param name="vm">Delivery form model</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SelectDeliveryOption(DeliveryPageViewModel vm)
        {
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            if (ModelState.IsValid)
            {
                // Save selected delivery option
                var shipment = _basketRepository.GetPackageBasket().First();
                var deliveryOption = shipment.ShipmentRateQuotes()
                    .Single(x => x.ShipMethod.Key == vm.SelectedDeliveryOption);

                _basketRepository.SaveShipmentRateQuote(deliveryOption);	

                return RedirectToUmbracoPage(GetPaymentPageNode().Id);
            }

            return CurrentUmbracoPage();
        }
    }
}