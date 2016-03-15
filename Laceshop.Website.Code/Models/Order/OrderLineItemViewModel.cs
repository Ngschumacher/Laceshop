using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laceshop.Website.Code.Models.Order
{
    public class OrderLineItemViewModel
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
