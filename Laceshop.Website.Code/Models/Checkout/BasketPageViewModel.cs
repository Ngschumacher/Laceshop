using Laceshop.Models.Products;
using Laceshop.Website.Code.Models.Basket;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class BasketPageViewModel : BasePageViewModel
    {
        public BasketViewModel Basket { get; set; }
        public string CheckoutPageUrl { get; set; }
  }
}