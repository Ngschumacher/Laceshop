using System.Web.Mvc;
using Laceshop.Controllers;
using Laceshop.Models;
using Laceshop.Website.Code.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers
{
    public class HomeController : BaseSurfaceController<HomePageViewModel>
    {
        #region Constructor

        public HomeController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }

        #endregion

        #region Action Methods

        /// <summary>
        /// Renders the home page
        /// </summary>
        /// <returns></returns>
        //public override ActionResult Index(RenderModel model)
        //{
        //    var vm = GetPageModel<HomePageViewModel>();
        //    //var viewModel = new HomePageViewModel();
        //    //// Map properties of current page to the ViewModel

        //    //_umbracoMapper.Map(CurrentPage, viewModel);
        //    return View("Home", vm);
        //}
        public ActionResult Home()
        {
            var vm = GetPageModel<HomePageViewModel>();
            return CurrentTemplate(vm);
        }

        #endregion
    }
}