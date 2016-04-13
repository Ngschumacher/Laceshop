using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Core.Interfaces.Basket;
using Core.Models.Commerce;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Laceshop.Website.Code.Models.Navigation;
using Laceshop.Website.Code.Models.Products;
using Merchello.Web;
using Merchello.Web.Models.VirtualContent;
using Merchello.Web.WebApi;
using Merchello.Web.Workflow;
using Umbraco.Core.Models;
using Umbraco.Web;
using Umbraco.Web.WebApi;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.ApiControllers
{
    public class ProductController : UmbracoApiController
    {
        private readonly IBasketRepository _basketRepository;

        public ProductController(IBasketRepository basketRepository)
        {
            _basketRepository = basketRepository;
        }

        [HttpGet]
        public ProductViewModel GetProduct(string key, Guid[] options)
        {
            var productService = Services.ProductService();
            var productvariantService = Services.ProductVariantService();

            var merchelloHelper = new MerchelloHelper();
            var productContent = merchelloHelper.TypedProductContent(key);
            var product = productService.GetByKey(new Guid(key));
            
            if (options == null)
            {
                options = new List<Guid>().ToArray();

            }
            
            var variantByOptions = productvariantService.GetProductVariantWithAttributes(product, options);

            var variantKey = variantByOptions != null ? variantByOptions.Key : product.ProductVariants.FirstOrDefault().Key;

            var variant = productContent.ProductVariants.First(x => x.Key == variantKey);


            var vm = GetViewModel(productContent, variant);

            productService.GetProductVariantByKey(new Guid());

            var reloadData = new List<string>() { "Color" };

            var variantOptions = productContent.ProductOptions.Select(x => new VariantOptionViewModel()
            {
                Key = x.Key,
                Name = x.Name,
                ReloadData = reloadData.Any(d => d == x.Name),
                Options = x.Choices.Select(option =>
                {
                    var productAttributeDisplay = variant.Attributes.FirstOrDefault(attr => attr.OptionKey == option.OptionKey);
                    return new OptionViewModel()
                    {
                        Key = option.Key,
                        Name = option.Name,
                        SortOrder = option.SortOrder,
                        Selected =
                            productAttributeDisplay != null && productAttributeDisplay.Key ==
                            option.Key
                    };
                }).OrderBy(sort => sort.SortOrder).ToList()
            }).ToList();


            //var productDetail = new ProductDetail();
            //AutoMapper.Mapper.Map(productContent, productDetail);
            vm.VariantOptions = variantOptions;
            return vm;
        }
        private ProductViewModel GetViewModel(IProductContent product, IProductVariantContent productVariant)
        {
            var vm = new ProductViewModel();

            var productDetail = new ProductDetail();
            AutoMapper.Mapper.Map(product, productDetail);
            
            var imageIds = productDetail.ImageIds;

            vm.ImageUrls = Umbraco.TypedMedia(imageIds).Select(x => x.Url).ToList();
            vm.Product = productDetail;
            vm.Variants = GetVariantAttributes(product);
            return vm;
        }

        public List<VariantViewModel> GetVariantAttributes(IProductContent product)
        {
            
            return product.ProductVariants.Select(x =>
            {

                List<string> images = new List<string>();
                if (x.HasProperty("Images"))
                {
                    var imageIds = x.GetPropertyValue("Images").ToString().Split(',').ToList();
                    images = Umbraco.TypedMedia(imageIds).Select(img => img.Url).ToList();
                }
                return new VariantViewModel()
                {
                    Key = x.Key,
                    Name = x.Name,
                    Url = x.Url,
                    ImageUrls = images,
                    Attributes = x.Attributes.Select(attr =>
                    {
                        var productOptionDisplay =
                            product.ProductOptions.FirstOrDefault(option => option.Key == attr.OptionKey);
                        var productOptionDisplayName = string.Empty;
                        if (productOptionDisplay != null)
                        {
                            productOptionDisplayName = productOptionDisplay.Name;
                        }
                        return new VariantAttributeViewModel()
                        {
                            Key = attr.OptionKey,
                            Name = productOptionDisplayName,
                            Value = new AttributeOptionViewModel()
                            {
                                Key = attr.Key,
                                Name = attr.Name
                            }
                        };
                    }).ToList()
                };
            }).ToList();
        }
    }
}