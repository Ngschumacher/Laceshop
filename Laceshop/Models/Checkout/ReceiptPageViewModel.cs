using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Laceshop.Models.Commerce;
using Laceshop.Models.Products;

namespace Laceshop.Models.Checkout
{
    public class ReceiptPageViewModel : BasePageViewModel
    {
        public InvoiceDetail InvoiceDetail { get; set; }
    }
}