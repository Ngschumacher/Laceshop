using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Models;
using Umbraco.Core.Logging;
using Umbraco.Web.Mvc;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Basket
{
    public class AddItemModel
    {
        ///
        /// Content Id of the ProductDetail page
        ///
        public int ContentId { get; set; }

        ///
        /// The Product Key (pk) of the product to be added to the cart.
        ///
        public Guid ProductKey { get; set; }
        public Guid[] OptionKeys { get; set; }
    }
    public class BasketPageController : BaseSurfaceController<BasketPageViewModel>
    {
        private readonly IBasketRepository _basketRepository;

        public BasketPageController(IUmbracoMapper mapper, IBasketRepository basketRepository) : base(mapper)
        {
            _basketRepository = basketRepository;
        }
      
        public  ActionResult BasketPage()
        {
            var basketVm = AutoMapper.Mapper.Map<BasketViewModel>(Basket);
            var vm = GetPageModel<BasketPageViewModel>();
            vm.Basket = basketVm;
            
            vm.CheckoutPageUrl = GetCheckoutPageNode().Url;

            return CurrentTemplate(vm);
        }

        public ActionResult Empty()
        {
            
            return BasketPage();
        }
        public ActionResult Display_BuyButton(AddItemModel product)
        {
            return PartialView("Partials/_BuyButton", product);
        }
        [HttpPost]
        public ActionResult AddItem(AddItemModel model)
        {
            // add Umbraco content id to Merchello Product extended data
            var extendedData = new Dictionary<string, string>
            {
                {"umbracoContentId", model.ContentId.ToString(CultureInfo.InvariantCulture)}
            };
            _basketRepository.AddItem(model.ProductKey, 1, extendedData, model.OptionKeys);

            return RedirectToBasketPage();
        }
       
        [HttpPost]
        public ActionResult UpdateItemQuantity(Guid itemKey, int quantity)
        {
            _basketRepository.UpdateItem(itemKey, quantity);
            return RedirectToBasketPage();
        }
     
        [HttpPost]
        public ActionResult RemoveItemFromBasket(Guid itemKey)
        {
            var basket = _basketRepository.GetBasket();
            if (basket.Items.FirstOrDefault(x => x.Key == itemKey) == null)
            {
                var exception = new InvalidOperationException("Attempt to delete an item from a basket that does not match the CurrentUser");

                LogHelper.Error<BasketPageController>("RemoveItemFromBasket failed.", exception);

                throw exception;
            }

            _basketRepository.RemoveItem(itemKey);
            return RedirectToBasketPage();
        }
    }
}