using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Models.Commerce
{
    public class BasketDetail
    {
        public decimal TotalProductPrice { get; set; }

        public decimal DeliveryPrice { get; set; }

        public decimal TotalOrderPrice
        {
            get
            {
                return TotalProductPrice + DeliveryPrice;
            }
        }

        public IEnumerable<LineItem> Items { get; set; }

        public bool HasItems
        {
            get
            {
                return Items != null && Items.Any();
            }
        }

        public class LineItem
        {
            public Guid Key { get; set; }

            public string Name { get; set; }

            public string ProductPageUrl { get; set; }

            public int Quantity { get; set; }

            public decimal Price { get; set; }

            public decimal TotalPrice
            {
                get
                {
                    return Quantity * Price;
                }
            }
        }
    }
}