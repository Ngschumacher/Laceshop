using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Models.Basket;
using Laceshop.Models.Checkout;
using Merchello.Core.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers.Checkout
{
    public class DeliveryPageController : BaseSurfaceController<DeliveryPageViewModel>
    {
        private readonly IBasketRepository _basketRepository;

        public DeliveryPageController(IUmbracoMapper mapper, IBasketRepository basketRepository) : base(mapper)
        {
            _basketRepository = basketRepository;
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
            vm.Basket = AutoMapper.Mapper.Map<BasketViewModel>(basket);
            vm.Basket.ShowOrderTotal = true;
            var deliveryOptions = shipment.ShipmentRateQuotes()
                .OrderBy(x => x.Rate)
                .Select(x => new SelectListItem()
                {
                    Value = x.ShipMethod.Key.ToString(),
                    Text = x.ShipMethod.Name + " $" + x.Rate.ToString("N2"),
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