using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using Laceshop.Models.Products;
using Laceshop.Website.Code.Models.Basket;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class DeliveryPageViewModel : BasePageViewModel
    {
        public BasketViewModel Basket { get; set; }
        [Required(ErrorMessage = "Please select a delivery option")]
        [Display(Name = "Delivery option")]
        public Guid SelectedDeliveryOption { get; set; }

        public SelectList DeliveryOptions { get; set; }

        public bool AllowBasketEdit { get; set; }


        public bool ShowOrderTotal { get; set; }
    }
}