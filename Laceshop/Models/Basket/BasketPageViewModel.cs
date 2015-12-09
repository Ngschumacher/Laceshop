using Core.Models;
using Core.Models.Commerce;
using Laceshop.Models.Commerce;
using Laceshop.Models.Interfaces;
using Merchello.Web.Workflow;

namespace Laceshop.Models.Basket
{
    public class BasketPageViewModel : BasePageViewModel
    {
        public BasketViewModel Basket { get; set; }

        public bool AllowBasketEdit
        {
            get
            {
                return true;
            }
        }

        public bool ShowOrderTotal
        {
            get
            {
                return false;
            }
        }

        public string CheckoutPageUrl { get; set; }
  }
}