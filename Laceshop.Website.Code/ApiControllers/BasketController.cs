using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Core.Interfaces.Basket;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Laceshop.Website.Code.Models.Navigation;
using Merchello.Web;
using Merchello.Web.WebApi;
using Merchello.Web.Workflow;
using Umbraco.Core.Models;
using Umbraco.Web;
using Umbraco.Web.WebApi;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.ApiControllers
{
    public class BasketController : UmbracoApiController
    {
        private readonly IBasketRepository _basketRepository;

        public BasketController(IBasketRepository basketRepository)
        {
            _basketRepository = basketRepository;
        }

        [HttpGet]
        public BasketViewModel GetBasket()
        {
            var customerContext = new CustomerContext(UmbracoContext);
            var currenctCustomer = customerContext.CurrentCustomer;
            var basket = currenctCustomer.Basket();

            var basketVm = AutoMapper.Mapper.Map<BasketViewModel>(basket);

            return basketVm;
        }

        [HttpDelete]
        public BasketViewModel RemoveItem(Guid id)
        {
            _basketRepository.RemoveItem(id);
            return GetBasket();
        }

        [HttpPost]
        public BasketViewModel UpdateItemQuantity(UpdateItemQuantityModel model)
        {
            _basketRepository.UpdateItem(model.Id, model.Quantity);
            return GetBasket();
        }

         [HttpPost]
        public BasketViewModel AddItem(UpdateItemQuantityModel model)
        {
            _basketRepository.AddVariantItem(model.Id, model.Quantity);
            return GetBasket();
        }




     public class UpdateItemQuantityModel
     {
         public Guid Id { get; set; }
         public int Quantity { get; set; }
     }
    }
}