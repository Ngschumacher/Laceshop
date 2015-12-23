using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Interfaces.Product;
using Core.Models.Commerce;
using Laceshop.Models;
using Laceshop.Models.Products;
using Merchello.Web;
using Merchello.Web.Models.ContentEditing;
using Umbraco.Core.Models;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers.Products
{
    

    public class ProductController : BaseSurfaceController<ProductPageViewModel>
    {
        private readonly IProductRepository _productRepository;

        public ProductController(IUmbracoMapper mapper, IProductRepository productRepository)
            : base(mapper)
        {
            _productRepository = productRepository;
        }

        public override ActionResult Index(RenderModel model)
        {
            var current = CurrentPage;
            //_productRepository.GetProduct();
            var viewModel = GetModel<ProductPageViewModel>();
            return View("Index", viewModel);
        }

        public ActionResult Product()
        {
            var vm = GetPageModel<ProductPageViewModel>();
            return CurrentTemplate(vm);
        }
       
    }
}