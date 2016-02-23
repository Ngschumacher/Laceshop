using System.Web.Mvc;
using Laceshop.Controllers;
using Laceshop.Website.Code.Models.Checkout;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class ReceiptPageController : BaseSurfaceController<ReceiptPageViewModel>
    {
        #region Constructor

        public ReceiptPageController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }

        #endregion

        #region Action Methods

        /// <summary>
        /// Renders the receipt page
        /// </summary>
        /// <returns></returns>
        public ActionResult ReceiptPage()
        {
            var vm = GetPageModel<ReceiptPageViewModel>();
            return CurrentTemplate(vm);
        }

        #endregion
    }
}