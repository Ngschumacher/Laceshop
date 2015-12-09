using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Models;
using Core.Models.Commerce;
using Merchello.Core.Models;
using Merchello.Web.Workflow;

namespace Core.Interfaces.Basket
{
    public interface IBasketRepository
    {
        BasketDetail GetBasket();
        void AddItem(Guid productGuid);
        void AddItem(Guid productGuid, int quantity);
        void AddItem(Guid productGuid, int quantity, Dictionary<string,string> extendedData);
        void UpdateItem(Guid itemKey, int quantity);
    }
}
