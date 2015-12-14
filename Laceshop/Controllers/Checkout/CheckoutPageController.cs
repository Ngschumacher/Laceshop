using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Models.Checkout;
using Merchello.Core.Models;
using Merchello.Web;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers.Checkout
{
    public class CheckoutPageController : BaseSurfaceController
    {
        private readonly IBasketRepository _basketRepository;

        public CheckoutPageController(IUmbracoMapper mapper, IBasketRepository basketRepository) : base(mapper)
        {
            _basketRepository = basketRepository;
        }

        public ActionResult CheckoutPage()
        {
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            var vm = GetPageModel<CheckoutPageViewModel>();
            return CurrentTemplate(vm);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CollectAddress(CheckoutPageViewModel vm)
        {
            var basket = _basketRepository.GetBasket();
            if (!basket.HasItems)
            {
                return RedirectToBasketPage();
            }

            if (ModelState.IsValid)
            {
                // Save billing and shipping addresses
                var address = new Address
                {
                    Address1 = vm.Address1,
                    Address2 = vm.Address2,
                    CountryCode = "GB",
                    Email = vm.Email,
                    Locality = vm.City,
                    Name = vm.CustomerName,
                    Phone = vm.Telephone,
                    PostalCode = vm.Postcode,
                    Region = vm.County,
                };


                var customerContext = new CustomerContext(UmbracoContext);
                var currentCustomer = customerContext.CurrentCustomer;
                var basket1 =  currentCustomer.Basket();


                var preparation = basket1.SalePreparation();
                preparation.SaveBillToAddress(address);
                preparation.SaveShipToAddress(address);


                _basketRepository.SaveBillToAddress(address);
                var bill = _basketRepository.GetBillToAddress();
                _basketRepository.SaveShipToAddress(address);
                var shipping = _basketRepository.GetShipToAddress();
                





                return RedirectToUmbracoPage(GetDeliveryPageNode().Id);
            }

            return CurrentUmbracoPage();
        }
    }
}