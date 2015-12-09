using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Models.Commerce;
using Laceshop.Models;
using Laceshop.Models.Commerce;
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
    public class ProductsViewModel : BasePageViewModel
    {
        public IHtmlString ProductDescription { get; set; }

        public ProductsViewModel()
        {
            Products = new List<ProductPageTeaser>();
        }
        public IList<ProductPageTeaser> Products { get; set; }
    }

    public class ProductsController : BaseRenderMvcController
    {
        public ProductsController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }

        //public ActionResult ProductPage(RenderModel model)
        //{

        //    //var vm = GetPageModel<ProductPageViewModel>();
        //    //return CurrentTemplate(vm);

        //    var viewModel = new ProductPageViewModel();
        //    // Map properties of current page to the ViewModel

        //    UmbracoMapper.Map(CurrentPage, viewModel);
        //    // render our view
        //    return CurrentTemplate(viewModel);
        //    return View("ProductPage", viewModel);

        //}
        public override ActionResult Index(RenderModel model)
        {
            // create our ViewModel
            var viewModel = GetModel<ProductsViewModel>();
            var test = CurrentPage.Children.ToList();
            // Map properties of current page to the ViewModel
            _umbracoMapper.MapCollection(CurrentPage.Children, viewModel.Products);
            _umbracoMapper.Map(CurrentPage, viewModel);
            // render our view
            return View("Products", viewModel);

            //CurrentPage
            //var vm = GetPageModel<ProductPageViewModel>();
            //return CurrentTemplate(vm);
        }
       
    }
}