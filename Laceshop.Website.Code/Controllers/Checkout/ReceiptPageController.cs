using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Laceshop.Models.Checkout;
using Laceshop.Website.Code.Models.Checkout;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers.Checkout
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