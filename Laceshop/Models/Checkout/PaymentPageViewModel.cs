using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Models.Commerce;
using Laceshop.Models.Basket;
using Laceshop.Models.Products;
using Merchello.Web.Workflow;

namespace Laceshop.Models.Checkout
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