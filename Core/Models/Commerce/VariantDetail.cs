using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Models.Commerce
{
    public class VariantDetail
    {
        public Guid Key { get; set; }
        public decimal Price { get; set; }
        public decimal SalePrice { get; set; }
        public bool OnSale { get; set; }
        public string Name { get; set; }
        public bool HasVariantsWithPriceRange { get; set; }
        public string Manufacturer { get; set; }
        public string ManufacturerModelNumber { get; set; }
        public bool Taxable { get; set; }
        public bool Available { get; set; }
        public string Description { get; set; }
        public List<int> ImageIds { get; set; }
    }
}
