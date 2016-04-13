using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Core.Models.Commerce;
using Laceshop.Website.Code.Models.Products;
using Merchello.Core.Models;
using Merchello.Core.Persistence.Repositories;
using Merchello.Web;
using Merchello.Web.Models.VirtualContent;
using Umbraco.Core.Services;
using Umbraco.Web;
using Umbraco.Web.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Products
{
    

    public class ProductController : BaseSurfaceController<ProductPageViewModel>
    {
        private readonly IMediaService _mediaService;
        private readonly IProductRepository _productRepository;

        public ProductController(IUmbracoMapper mapper, IMediaService mediaService)
            : base(mapper)
        {
            _mediaService = mediaService;
        }

        public override ActionResult Index(RenderModel model)
        {
            var customer = CurrentCustomer.Basket().Customer;
            var current = CurrentPage;
            Services.ProductService();
            Services.ProductVariantService();

           



            var viewModel = GetModel<ProductPageViewModel>();
            return View("Index", viewModel);
        }

        public ActionResult Product(Guid[] options)
        {
            var productService = Services.ProductService();
            var productvariantService = Services.ProductVariantService();

            var productContent = CurrentPage as IProductContent;
            var product = productService.GetByKey(productContent.Key);
            if (options == null)
            {
                options = new List<Guid>().ToArray();
                
            }
            var variantByOptions = productvariantService.GetProductVariantWithAttributes(product, options);

            var variantKey = variantByOptions != null ? variantByOptions.Key : product.ProductVariants.FirstOrDefault().Key;

            var variant = productContent.ProductVariants.First(x => x.Key == variantKey);


            var vm = GetViewModel(productContent, variant);

            var teste = product.ProductVariants.Select(x => x.Sku).ToList();

            var test = productvariantService.GetBySku("Tan");
          
            productService.GetProductVariantByKey(new Guid());

            var reloadData = new List<string>() {"Color"};

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
                        Key = option.OptionKey,
                        Name = option.Name,
                        SortOrder = option.SortOrder,
                        Selected =
                            productAttributeDisplay != null && productAttributeDisplay.Key ==
                            option.Key
                    };
                }).OrderBy(sort => sort.SortOrder).ToList()
            }).ToList();


            var productDetail = new ProductDetail();
            AutoMapper.Mapper.Map(productContent, productDetail);
            //vm.Variants = variantOptions;
            return CurrentTemplate(vm);
        }

        private ProductPageViewModel GetViewModel(IProductContent product, IProductVariantContent productVariant)
        {
            var vm = GetPageModel<ProductPageViewModel>();

            var productDetail = new ProductDetail();
            AutoMapper.Mapper.Map(product, productDetail);
            if (productVariant != null)
            {
                VariantDetail variantDetail = AutoMapper.Mapper.Map<VariantDetail>(productVariant);
                if (variantDetail != null)
                {
                    variantDetail.ImageIds.AddRange(productDetail.ImageIds);
                    productDetail.ImageIds = variantDetail.ImageIds;
                    productDetail.Name = variantDetail.Name;
                    productDetail.Price = variantDetail.Price;
                    productDetail.SalePrice = variantDetail.SalePrice;
                    productDetail.OnSale = variantDetail.OnSale;
                }
            }

            var imageIds = productDetail.ImageIds;



            vm.Images = Umbraco.TypedMedia(imageIds).ToList();
            vm.Product = productDetail;
            return vm;
        }
    }
}