using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using Laceshop.Models.Basket;
using Laceshop.Models.Checkout;
using Laceshop.Models.Products;
using Laceshop.Website.Code.Models.Basket;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class PaymentPageViewModel : BasePageViewModel
    {
        [Required(ErrorMessage = "Please select a payment method")]
        [Display(Name = "Payment method")]
        public Guid SelectedPaymentMethod { get; set; }

        public SelectList PaymentMethods { get; set; }

        public BasketViewModel Basket { get; set; }

        public CardDetailViewModel CardDetail { get; set; }
	    public Guid ShipMethodKey { get; set; }
	    public Guid PaymentMethodKey { get; set; }
	    public object CustomerToken { get; set; }
	    public object ReceiptPageId { get; set; }
    }
}