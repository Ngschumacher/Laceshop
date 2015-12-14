using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Models.Commerce;
using Laceshop.Models.Basket;
using Laceshop.Models.Products;
using Merchello.Web.Workflow;

namespace Laceshop.Models.Checkout
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