using System.Linq;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Laceshop.Website.Code.Models.Order;
using Merchello.Core.Checkout;
using Merchello.Core.Models;
using Merchello.Web;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class CheckoutPageController : BaseSurfaceController
    {
        private readonly IBasketRepository _basketRepository;
        private readonly ICheckoutCustomerManager _customerManager;
        public CheckoutPageController(IUmbracoMapper mapper, IBasketRepository basketRepository)
            : base(mapper)
        {
            _basketRepository = basketRepository;
            var settings = new CheckoutContextSettings()
            {
                ResetShippingManagerDataOnVersionChange = false
            };
            var checkoutManager = Basket.GetCheckoutManager(settings);
            _customerManager = checkoutManager.Customer;

        }

        public ActionResult CheckoutPage()
        {
            //SetShippingInfomation();
            
            if (Basket.IsEmpty)
            {
                return RedirectToBasketPage();
            }
   //         var basketReadyForInvoice = _paymentManager.IsReadyToInvoice();
			//_paymentManager.
   //         if (!basketReadyForInvoice)
   //         {
   //             return RedirectToUmbracoPage(GetBasketPageNode().Id);
   //         }
            var address = _customerManager.GetBillToAddress();
            
            
            var vm = GetPageModel<CheckoutPageViewModel>();
			AutoMapper.Mapper.Map(address, vm);

            //var invoice = _paymentManager.PrepareInvoice();


            vm.Basket = AutoMapper.Mapper.Map<BasketViewModel>(Basket);
            return CurrentTemplate(vm);
        }

        private void SetShippingInfomation()
        {

            var address = _customerManager.GetShipToAddress();
            var shipment = Basket.PackageBasket(address).First();
            var deliveryOption = shipment.ShipmentRateQuotes()
                .FirstOrDefault();

            _shippingManager.ClearShipmentRateQuotes();
            _shippingManager.SaveShipmentRateQuote(deliveryOption);	
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CollectAddress(CheckoutPageViewModel vm)
        {

            if (Basket.IsEmpty)
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
                
                _customerManager.SaveBillToAddress(address);
                _customerManager.SaveShipToAddress(address);
                return RedirectToUmbracoPage(GetPaymentPageNode().Id);
            }

            return CurrentUmbracoPage();
        }
    }
}