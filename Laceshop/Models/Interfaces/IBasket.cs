using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Core.Models.Commerce;

namespace Laceshop.Models.Interfaces
{
    public interface IBasketView
    {
        BasketDetail BasketDetail { get; }

        bool AllowBasketEdit { get; }

        bool ShowOrderTotal { get; }
    }
}