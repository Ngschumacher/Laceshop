using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Core.Models.Commerce
{
    public class ProductDetail
    {
        public Guid Key { get; set; }

        public decimal Price { get; set; }

        public decimal SalePrice { get; set; }

        public bool OnSale { get; set; }

        public bool HasVariantsWithPriceRange { get; set; }

        public IEnumerable<Option> Options { get; set; }
        public string Manufacturer { get; set; }
        public string ManufacturerModelNumber { get; set; }
        public bool Taxable { get; set; }
        public bool Available { get; set; }

        public class Option
        {
            public Guid Key { get; set; }

            public string Name { get; set; }

            public SelectList Choices { get; set; }
        }
    }
}