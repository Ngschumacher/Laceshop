using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Laceshop.Models;
using Umbraco.Web.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers
{
    public class HomeController : BaseRenderMvcController
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
        public override ActionResult Index(RenderModel model)
        {
            var vm = GetPageModel<HomePageViewModel>();
            //var viewModel = new HomePageViewModel();
            //// Map properties of current page to the ViewModel

            //_umbracoMapper.Map(CurrentPage, viewModel);
            return View("Home", vm);
        }

        #endregion
    }
}