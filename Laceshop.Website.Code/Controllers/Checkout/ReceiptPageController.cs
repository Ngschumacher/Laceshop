using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using Core.Interfaces.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Umbraco.Core.Logging;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class ReceiptPageController : BaseSurfaceController<ReceiptPageViewModel>
    {
        #region Constructor
        private readonly IBasketRepository _basketRepository;
        public ReceiptPageController(IUmbracoMapper mapper, IBasketRepository basketRepository)
            : base(mapper)
        {
            _basketRepository = basketRepository;
        }

        #endregion

        #region Action Methods

        /// <summary>
        /// Renders the receipt page
        /// </summary>
        /// <returns></returns>
        public ActionResult ReceiptPage(string id)
        {
            IInvoice invoice = MerchelloContext.Current.Services.InvoiceService.GetByInvoiceNumber(int.Parse(id));
            Basket.Customer.ResetDirtyProperties();
            Basket.Empty();

            var vm = GetPageModel<ReceiptPageViewModel>();
            return CurrentTemplate(vm);
        }
        #endregion
    }
}