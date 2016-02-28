using System.Web.Mvc;
using Laceshop.Website.Code.Models.Products;
using Merchello.Core.Persistence.Repositories;
using Merchello.Web;
using Umbraco.Web.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Products
{
    

    public class ProductController : BaseSurfaceController<ProductPageViewModel>
    {
        private readonly IProductRepository _productRepository;

        public ProductController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }

        public override ActionResult Index(RenderModel model)
        {
            var customer = CurrentCustomer.Basket().Customer;
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