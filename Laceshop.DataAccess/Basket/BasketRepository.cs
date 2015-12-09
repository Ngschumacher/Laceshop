using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Interfaces.Basket;
using Core.Models;
using Core.Models.Commerce;
using Merchello.Core.Models;
using Merchello.Core.Services;
using Merchello.Web;
using Merchello.Web.Pluggable;
using Merchello.Web.Workflow;
using Umbraco.Web;

namespace Laceshop.DataAccess.Basket
{
    public  class BasketRepository : IBasketRepository

    {
        private readonly CustomerContext _costumerContext;
        private readonly IProductService _productService;
        private readonly IBasket _basket;
        public BasketRepository(CustomerContext costumerContext, IProductService productService)
        {
            _costumerContext = costumerContext;
            _productService = productService;
            _basket = _costumerContext.CurrentCustomer.Basket();
        }

        public BasketDetail GetBasket()
        {
            return AutoMapper.Mapper.Map<BasketDetail>(_basket);
        }

        public void AddItem(Guid productGuid)
        {
            var product = _productService.GetByKey(productGuid);
            _basket.AddItem(product);
            _basket.Save();
        }
        public void AddItem(Guid productGuid, int quantity)
        {
            var product = _productService.GetByKey(productGuid);
            _basket.AddItem(product, product.Name, quantity);
            _basket.Save();
        }

        public void AddItem(Guid productGuid, int quantity, Dictionary<string, string> extendedData)
        {
            var data = ConvertDictionaryToExtendedDataCollection(extendedData);
            var product = _productService.GetByKey(productGuid);
            _basket.AddItem(product, product.Name, quantity, data);
            _basket.Save();
        }

        public void UpdateItem(Guid itemKey, int quantity)
        {
            if (_basket.Items.FirstOrDefault(x => x.Key == itemKey) != null)
            {
                _basket.UpdateQuantity(itemKey, quantity);
                _basket.Save();
            }
        }

        private ExtendedDataCollection ConvertDictionaryToExtendedDataCollection(Dictionary<string, string> dictionary)
        {
            var extendedDataCollection = new ExtendedDataCollection();
            foreach (var item in dictionary)
            {
                extendedDataCollection.SetValue(item.Key, item.Value);
            }
            return extendedDataCollection;
        }
    }
}
