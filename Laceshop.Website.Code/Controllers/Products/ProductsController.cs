using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Laceshop.Models.Products;
using Laceshop.Website.Code.Models.Products;
using Merchello.Web;
using Merchello.Web.Models.VirtualContent;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Products
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
            var productService = MerchelloServices.ProductService;
            var products = productService.GetAll().ToList();
            var first = products.FirstOrDefault();

            var test = CurrentPage as IProductContent;

            var viewModel = GetModel<ProductsViewModel>();

            _umbracoMapper.MapCollection(CurrentPage.Children, viewModel.Products);
            _umbracoMapper.Map(CurrentPage, viewModel);
            //CurrentPage
            //var vm = GetPageModel<ProductPageViewModel>();
            return CurrentTemplate(viewModel);
        }
       
    }
}