using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Core.Models.Commerce;
using Laceshop.Controllers.Products;
using Laceshop.Models;
using Laceshop.Models.Basket;
using Merchello.Core.Models;
using Merchello.Web;
using Umbraco.Core.Logging;
using Umbraco.Web;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers.Basket
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
    }
    [PluginController("MerchelloProductListExample")]
    public class BasketController : BaseRenderMvcController
    {
        private readonly IBasketRepository _basketRepository;

        public BasketController(IUmbracoMapper mapper, IBasketRepository basketRepository) : base(mapper)
        {
            _basketRepository = basketRepository;
        }

        private const int BasketContentId = 2077;
        public override ActionResult Index(RenderModel model)
        {
            var test = _basketRepository.GetBasket();
            
            //var viewModel = GetModel<BasketDetail>();

            var basketVm = AutoMapper.Mapper.Map<BasketViewModel>(test);

            var vm = new BasketPageViewModel()
            {
                Basket = basketVm
            };


            //_umbracoMapper.Map(CurrentPage, viewModel);

            return View("Basket", vm);
        }
        public ActionResult Display_BuyButton(AddItemModel product)
        {
            return PartialView("BuyButton", product);
        }
        [HttpPost]
        public ActionResult AddToBasket(AddItemModel model)
        {
            // add Umbraco content id to Merchello Product extended data
            var extendedData = new Dictionary<string, string>
            {
                {"umbracoContentId", model.ContentId.ToString(CultureInfo.InvariantCulture)}
            };




            _basketRepository.AddItem(model.ProductKey, 1, extendedData);

            return RedirectToUmbracoPage(BasketContentId);
        }
       
        [HttpPost]
        public ActionResult UpdateItemQuantity(Guid itemKey, int quantity)
        {
            var basket = _basketRepository.GetBasket();
            _basketRepository.UpdateItem(itemKey, quantity);
            // Validate requested item in basket and update the quantity
           

            return RedirectToBasketPage();
        }

        ///
        /// Removes an item from the basket
        ///
        [HttpGet]
        public ActionResult RemoveItemFromBasket(Guid lineItemKey)
        {
            var basket = _basketRepository.GetBasket();
            if (basket.Items.FirstOrDefault(x => x.Key == lineItemKey) == null)
            {
                var exception = new InvalidOperationException("Attempt to delete an item from a basket that does not match the CurrentUser");

                LogHelper.Error<BasketController>("RemoveItemFromBasket failed.", exception);

                throw exception;
            }

            // remove product 
            //basket.RemoveItem(lineItemKey);

            //basket.Save();

            return RedirectToBasketPage();
        }
    }
}