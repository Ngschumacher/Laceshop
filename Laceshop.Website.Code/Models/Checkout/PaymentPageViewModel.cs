using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using Laceshop.Models.Basket;
using Laceshop.Models.Checkout;
using Laceshop.Models.Products;
using Laceshop.Website.Code.Models.Basket;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class PaymentPageViewModel : BasePageViewModel
    {
        public BasketViewModel Basket { get; set; }

        public QuickPayModel QuickPayModel { get; set; }
    }
}