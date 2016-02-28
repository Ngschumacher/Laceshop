using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laceshop.Website.Code.Models.Checkout
{
    public class QuickPayModel
    {
        public string MerchantId { get; set; }
        public string AgreementId { get; set; }
        public string OrderId { get; set; }
        public string Amount { get; set; }
        public string Currency { get; set; }
        public string ContinueUrl  { get; set; }
        public string CancelUrl { get; set; }
        public string CallbackUrl { get; set; }
        public string Checksum { get; set; }
    }
}
