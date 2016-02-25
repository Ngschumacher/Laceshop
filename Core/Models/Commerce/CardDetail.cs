using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Models.Commerce
{
    public class CardDetail
    {
        public string Number { get; set; }
        public string CVV { get; set; }
        public byte? ExpiryMonth { get; set; }

        public short? ExpiryYear { get; set; }
    }
}
