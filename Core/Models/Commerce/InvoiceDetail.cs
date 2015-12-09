using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Laceshop.Models.Commerce
{
    public class InvoiceDetail
    {
        public DateTime InvoiceDate { get; set; }

        public int InvoiceNumber { get; set; }

        public string InvoiceStatus { get; set; }

        public decimal Total { get; set; }
    }
}