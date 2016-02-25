using System.Web;
using Core.Models.Commerce;
using Laceshop.Models.Products;

namespace Laceshop.Website.Code.Models.Products
{
    public class ProductPageViewModel : BasePageViewModel
    {
        public IHtmlString ProductDescription { get; set; }

        public ProductDetail Product { get; set; }
    }
}