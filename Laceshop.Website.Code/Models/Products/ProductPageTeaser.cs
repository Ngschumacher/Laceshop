using Core.Models.Commerce;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Models.Products
{
    public class ProductPageTeaser : BaseNodeViewModel
    {
        public string ProductDescription { get; set; }
        public ProductDetail ProductDetail { get; set; }
    }
}