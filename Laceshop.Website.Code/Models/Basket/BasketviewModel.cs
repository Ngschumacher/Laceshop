using System.Collections.Generic;

namespace Laceshop.Website.Code.Models.Basket
{
    public class BasketViewModel
    {
        public bool IsEmpty { get; set; }
        public IEnumerable<BasketLineViewModel> Items { get; set; }
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

	    public int TotalQuantityCount { get; set; }
        public bool ShowOrderTotal { get; set; }
    }
}