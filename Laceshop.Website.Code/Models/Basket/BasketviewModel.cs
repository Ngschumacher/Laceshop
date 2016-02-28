using System.Collections.Generic;
using Laceshop.Models.Basket;

namespace Laceshop.Website.Code.Models.Basket
{
    public class BasketViewModel
    {
        public bool IsEmpty { get; set; }
        public IEnumerable<BasketLineItemViewModel> Items { get; set; }
        public decimal TotalBasketPrice { get; set; }
        public decimal DeliveryPrice { get; set; }
        public decimal TotalOrderPrice
        {
            get
            {
                return TotalBasketPrice + DeliveryPrice;
            }
        }

        public bool AllowBasketEdit { get; set; }

        public BasketViewModel()
        {
            ShowOrderTotal = false;
            AllowBasketEdit = true;

        }

        public bool ShowOrderTotal { get; set; }
    }
}