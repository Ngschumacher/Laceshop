using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Models;
using Core.Models.Commerce;
using Merchello.Core.Gateways.Shipping;
using Merchello.Core.Models;
using Merchello.Web.Workflow;

namespace Core.Interfaces.Basket
{
    public interface IBasketRepository
    {
        BasketDetail GetBasket();
        void AddItem(Guid productGuid, Guid[] optionsKey = null);
        void AddItem(Guid productGuid, int quantity, Guid[] optionsKey = null);
        void AddItem(Guid productGuid, int quantity, Dictionary<string, string> extendedData, Guid[] optionsKey = null);
        void RemoveItem(Guid productGuid);
        void UpdateItem(Guid itemKey, int quantity);
        BasketSalePreparation SalePreparation();
        void SaveBillToAddress(Address address);
        void SaveShipToAddress(Address address);
        IAddress GetShipToAddress();
        IAddress GetBillToAddress();
        IEnumerable<IShipment> GetPackageBasket();
        void SaveShipmentRateQuote(IShipmentRateQuote shipmentRateQuote);
        void SavePaymentMethod(IPaymentMethod paymentMethod);
    }
}
