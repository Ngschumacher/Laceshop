using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Core.Models.Commerce;
using Zone.UmbracoMapper;

namespace Laceshop.Models.Products
{
    public class ProductPageTeaser : BaseNodeViewModel
    {
        public string ProductDescription { get; set; }
        public ProductDetail ProductDetail { get; set; }
    }
}