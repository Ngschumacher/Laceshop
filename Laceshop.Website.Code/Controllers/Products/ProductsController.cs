﻿using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Laceshop.Models.Products;
using Laceshop.Website.Code.Controllers;
using Laceshop.Website.Code.Models.Products;
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

    public class ProductsController : BaseSurfaceController
    {
        public ProductsController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }


        public  ActionResult Products()
        {
            // create our ViewModel
            var viewModel = GetModel<ProductsViewModel>();
            // Map properties of current page to the ViewModel
            _umbracoMapper.MapCollection(CurrentPage.Children, viewModel.Products);
            _umbracoMapper.Map(CurrentPage, viewModel);
            // render our view
            //return View("Products", viewModel);

            //CurrentPage
            //var vm = GetPageModel<ProductPageViewModel>();
            return CurrentTemplate(viewModel);
        }
       
    }
}