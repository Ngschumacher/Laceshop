using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Controllers;
using Laceshop.Models.Checkout;
using Merchello.Core.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
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
	        var address = _basketRepository.GetBillToAddress();

            var vm = GetPageModel<CheckoutPageViewModel>();
			AutoMapper.Mapper.Map(address, vm);
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
                    CountryCode = "DK",
                    Email = vm.Email,
                    Locality = vm.City,
                    Name = vm.CustomerName,
                    Phone = vm.Telephone,
                    PostalCode = vm.Postcode,
                    Region = vm.County,
                };

                _basketRepository.SaveBillToAddress(address);
                _basketRepository.SaveShipToAddress(address);

                return RedirectToUmbracoPage(GetDeliveryPageNode().Id);
            }

            return CurrentUmbracoPage();
        }
    }
}