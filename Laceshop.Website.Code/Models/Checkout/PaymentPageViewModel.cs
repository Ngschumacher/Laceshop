using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using Laceshop.Models.Checkout;
using Laceshop.Models.Products;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Order;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class PaymentPageViewModel : BasePageViewModel
    {
        public OrderViewModel Order { get; set; }

        public QuickPayModel QuickPayModel { get; set; }
    }
}