using Core.Models.Commerce;
using Laceshop.Models.Products;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class ReceiptPageViewModel : BasePageViewModel
    {
        public InvoiceDetail InvoiceDetail { get; set; }
    }
}