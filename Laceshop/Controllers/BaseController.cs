using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Models.Commerce;
using Laceshop.Mapping;
using Laceshop.Models;
using Laceshop.Models.Commerce;
using Laceshop.Models.Products;
using Merchello.Web;
using Merchello.Web.Workflow;
using Umbraco.Core.Models;
using Umbraco.Web;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers
{
    public abstract class BaseSurfaceController : SurfaceController, IRenderMvcController
    {
        #region tutorial
        private readonly IBasket _basket;
        protected IUmbracoMapper _umbracoMapper;
        #endregion

        #region Constructor

        protected BaseSurfaceController(IUmbracoMapper mapper)
        {
            _umbracoMapper = mapper;
            AddCustomMappings();
        }

        #endregion

        #region Properties

       

        #endregion

        #region Render MVC

        /// <summary>
        /// Locates the template for the given route
        /// </summary>
        /// <typeparam name="T">Model type</typeparam>
        /// <param name="model">Instance of model</param>
        /// <param name="viewName">View name</param>
        /// <returns>Template for given route</returns>
        protected ActionResult CurrentTemplate<T>(T model, string viewName = "")
        {
            if (string.IsNullOrEmpty(viewName))
            {
                viewName = ControllerContext.RouteData.Values["action"].ToString();
            }

            return View(viewName, model);
        }

        #endregion

        #region Mapping Helpers

        /// <summary>
        /// Populates a generic model
        /// </summary>
        /// <typeparam name="T">The View-Model</typeparam>
        /// <returns>Populated view model</returns>
        protected virtual T GetModel<T>()
              where T : class, new()
        {
            var model = new T();
            _umbracoMapper.Map(CurrentPage, model);
            return model;
        }

        /// <summary>
        /// Populates a generic page view model
        /// </summary>
        /// <typeparam name="T">The View-Model</typeparam>
        /// <returns>Populated page view model</returns>
        protected virtual T GetPageModel<T>()
             where T : BasePageViewModel, new()
        {
            var model = new T();

            // Set canonical url if requested url differs from current page url
            model.CanonicalUrl = Request.Url == null || Request.Url.AbsolutePath == CurrentPage.Url ? null : CurrentPage.UrlAbsolute();
            model.AbsoluteUrl = CurrentPage.UrlAbsolute();

            // Map page properties
            _umbracoMapper.Map(CurrentPage, model);

            return model;
        }

        /// <summary>
        /// Sets up the custom mappings for the Umbraco Mapper used in the project
        /// </summary>
        private void AddCustomMappings()
        {
            _umbracoMapper
                .AddCustomMapping(typeof(ProductDetail).FullName, CommerceMapper.GetProductDetail)
                .AddCustomMapping(typeof(BasketDetail).FullName, CommerceMapper.GetBasketDetail)
                .AddCustomMapping(typeof(InvoiceDetail).FullName, CommerceMapper.GetInvoiceDetail);
        }

        #endregion

        #region Querying helpers

        /// <summary>
        /// Gets the Umbraco root node (home page)
        /// </summary>
        /// <returns>Instance of IPublishedContent</returns>
        protected IPublishedContent GetRootNode()
        {
            return Umbraco.TypedContentAtRoot().FirstOrDefault();
        }

        /// <summary>
        /// Gets the basket page
        /// </summary>
        /// <returns>Instance of IPublishedContent</returns>
        protected IPublishedContent GetBasketPageNode()
        {
            return GetSingleNode("BasketPage");
        }

        /// <summary>
        /// Gets the checkout page
        /// </summary>
        /// <returns>Instance of IPublishedContent</returns>
        protected IPublishedContent GetCheckoutPageNode()
        {
            return GetSingleNode("CheckoutPage");
        }

        /// <summary>
        /// Gets the delivery page
        /// </summary>
        /// <returns>Instance of IPublishedContent</returns>
        protected IPublishedContent GetDeliveryPageNode()
        {
            return GetSingleNode("DeliveryPage");
        }

        /// <summary>
        /// Gets the payment page
        /// </summary>
        /// <returns>Instance of IPublishedContent</returns>
        protected IPublishedContent GetPaymentPageNode()
        {
            return GetSingleNode("PaymentPage");
        }

        /// <summary>
        /// Gets the receipt page
        /// </summary>
        /// <returns>Instance of IPublishedContent</returns>
        protected IPublishedContent GetReceiptPageNode()
        {
            return GetSingleNode("ReceiptPage");
        }

        private IPublishedContent GetSingleNode(string docTypeAlias)
        {
            return GetRootNode()
                .Descendants(docTypeAlias)
                .FirstOrDefault();
        }

        #endregion

        #region Commerce helpers

        /// <summary>
        /// Helper to retrieve Merchello basket
        /// </summary>
        /// <returns>Merchello basket instance</returns>
         //<summary>
         //Redirects to the basket page
         //</summary>
         //<returns>Redirect result</returns>
        protected ActionResult RedirectToBasketPage()
        {
            var basketNode = GetBasketPageNode();
            if (basketNode == null)
            {
                throw new NullReferenceException("Basket node could not be found");
            }

            return RedirectToUmbracoPage(basketNode.Id);
        }

        #endregion

        public virtual ActionResult Index(RenderModel model)
        {
            return CurrentTemplate(model);
        }
    }
}