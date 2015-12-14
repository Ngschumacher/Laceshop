﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Core.Helpers;
using Core.Interfaces.Basket;
using Core.Models;
using Core.Models.Commerce;
using Merchello.Core;
using Merchello.Core.Gateways.Shipping;
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
        private readonly IProductVariantService _productVariantService;
        private readonly IBasket _basket;
        public BasketRepository(CustomerContext costumerContext, IProductService productService, IProductVariantService productVariantService)
        {
            _costumerContext = costumerContext;
            _productService = productService;
            _productVariantService = productVariantService;
            _basket = _costumerContext.CurrentCustomer.Basket();
        }

        public BasketDetail GetBasket()
        {
            return AutoMapper.Mapper.Map<BasketDetail>(_basket);
        }

        public void AddItem(Guid productGuid, Guid[] optionsKey = null)
        {
            var product = _productService.GetByKey(productGuid);
            if (optionsKey.IsAndAny())
            {
                var variant = _productVariantService.GetProductVariantWithAttributes(product, optionsKey);
                _basket.AddItem(variant);
            }
            else
            {
                _basket.AddItem(product);
            }
            _basket.Save();
        }
        public void AddItem(Guid productGuid, int quantity, Guid[] optionsKey = null)
        {
            var product = _productService.GetByKey(productGuid);
            _basket.AddItem(product, product.Name, quantity);
            if (optionsKey.IsAndAny())
            {
                var variant = _productVariantService.GetProductVariantWithAttributes(product, optionsKey);
                _basket.AddItem(variant, variant.Name, quantity);
            }
            else
            {
                _basket.AddItem(product, product.Name, quantity);
            }
            _basket.Save();
        }

        public void AddItem(Guid productGuid, int quantity, Dictionary<string, string> extendedData, Guid[] optionsKey = null)
        {
            var data = ConvertDictionaryToExtendedDataCollection(extendedData);
            var product = _productService.GetByKey(productGuid);
            
            if (optionsKey.IsAndAny())
            {
                var variant = _productVariantService.GetProductVariantWithAttributes(product, optionsKey);
                _basket.AddItem(variant, variant.Name, quantity, data);
            }
            else
            {
                _basket.AddItem(product, product.Name, quantity, data);
            }
            _basket.Save();
        }

        public void RemoveItem(Guid productGuid)
        {
            _basket.RemoveItem(productGuid);
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

        public BasketSalePreparation SalePreparation()
        {
            var preparation = _basket.SalePreparation();
            return preparation;
        }

        public void SaveBillToAddress(Address address)
        {
            var salePreparation = SalePreparation();
            salePreparation.SaveBillToAddress(address);
        }

        public void SaveShipToAddress(Address address)
        {
            var salePreparation = SalePreparation();
            salePreparation.SaveShipToAddress(address);
        }
        public IAddress GetShipToAddress()
        {
            var salePreparation = SalePreparation();
            return salePreparation.GetShipToAddress();
        }
        public IAddress GetBillToAddress()
        {
            var salePreparation = SalePreparation();
            return salePreparation.GetBillToAddress();
        }

        public IEnumerable<IShipment> GetPackageBasket()
        {
            return _basket.PackageBasket(GetBillToAddress());

        }

        public void SaveShipmentRateQuote(IShipmentRateQuote shipmentRateQuote)
        {
            var salePreparation = SalePreparation();
            salePreparation.ClearShipmentRateQuotes();
            salePreparation.SaveShipmentRateQuote(shipmentRateQuote);
        }

        public void SavePaymentMethod(IPaymentMethod paymentMethod)
        {
            var preparation = SalePreparation();
            preparation.SavePaymentMethod(paymentMethod);
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

        private IProductBase AddItemToBasket(Guid productKey, int quantity, Guid[] optionsKey)
        {
            var product = _productService.GetByKey(productKey);
            if (optionsKey != null && optionsKey.Any())
            {
                var variant = _productVariantService.GetProductVariantWithAttributes(product, optionsKey);
            }
            else
            {
            }
            return product;
        }
    }
}
