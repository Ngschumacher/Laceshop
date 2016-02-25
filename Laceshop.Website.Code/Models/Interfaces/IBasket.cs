using Core.Models.Commerce;

namespace Laceshop.Website.Code.Models.Interfaces
{
    public interface IBasketView
    {
        BasketDetail BasketDetail { get; }

        bool AllowBasketEdit { get; }

        bool ShowOrderTotal { get; }
    }
}