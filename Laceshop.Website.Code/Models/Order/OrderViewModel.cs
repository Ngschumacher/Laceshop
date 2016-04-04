using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laceshop.Website.Code.Models.Order
{
    public class OrderViewModel
    {
          public bool IsEmpty { get; set; }
        public IEnumerable<OrderLineItemViewModel> Items { get; set; }
        public decimal Total { get; set; }
        public decimal TotalTax { get; set; }
        public decimal ShippingPirce { get; set; }
        public decimal TotalItemPrice { get; set; }
    }
}
