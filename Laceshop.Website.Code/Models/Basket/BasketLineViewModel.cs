using System;

namespace Laceshop.Website.Code.Models.Basket
{
    public class BasketLineViewModel
    {
        public Guid Key { get; set; }

        public string Name { get; set; }
        public int Quantity { get; set; }
        public string ProductPageUrl { get; set; }
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