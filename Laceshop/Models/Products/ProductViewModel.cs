using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Core.Models.Commerce;

namespace Laceshop.Models.Products
{
    public class ProductPageViewModel : BasePageViewModel
    {
        public IHtmlString ProductDescription { get; set; }

        public ProductDetail Product { get; set; }
    }
}