using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
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
        [HttpGet]
        public BasketViewModel GetBasket()
        {
            var customerContext = new CustomerContext(UmbracoContext);
            var currenctCustomer = customerContext.CurrentCustomer;
            var basket = currenctCustomer.Basket();

            var basketVm = AutoMapper.Mapper.Map<BasketViewModel>(basket);

            return basketVm;
        }
    }
}