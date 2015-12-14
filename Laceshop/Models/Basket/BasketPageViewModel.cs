using Core.Models;
using Core.Models.Commerce;
using Laceshop.Models.Commerce;
using Laceshop.Models.Interfaces;
using Laceshop.Models.Products;
using Merchello.Web.Workflow;

namespace Laceshop.Models.Basket
{
    public class BasketPageViewModel : BasePageViewModel
    {
        public BasketViewModel Basket { get; set; }
        public string CheckoutPageUrl { get; set; }
  }
}