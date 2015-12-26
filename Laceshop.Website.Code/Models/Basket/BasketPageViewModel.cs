using Laceshop.Models.Basket;
using Laceshop.Models.Products;

namespace Laceshop.Website.Code.Models.Basket
{
    public class BasketPageViewModel : BasePageViewModel
    {
        public BasketViewModel Basket { get; set; }
        public string CheckoutPageUrl { get; set; }
  }
}