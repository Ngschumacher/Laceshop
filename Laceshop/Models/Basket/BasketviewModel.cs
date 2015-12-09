using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Core.Models.Commerce;

namespace Laceshop.Models.Basket
{
    public class BasketViewModel
    {
        public bool HasItems { get; set; }
        public IEnumerable<BasketLineItemViewModel> Items { get; set; }
        public decimal TotalProductPrice { get; set; }
        public decimal DeliveryPrice { get; set; }
        public decimal TotalOrderPrice
        {
            get
            {
                return TotalProductPrice + DeliveryPrice;
            }
        }
    }
}