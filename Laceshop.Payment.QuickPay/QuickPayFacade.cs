using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Laceshop.Payment.QuickPay.Interfaces;

namespace Laceshop.Payment.QuickPay
{
    public class QuickPayFacade : IQuickPayFacade
    {
        private readonly IQuickPaySettings _quickPaySettings;
        private readonly IQuickPayChecksumService _quickPayChecksumService;

        public string AbsoluteCancelUrl { get; set; }

        public QuickPayFacade(IQuickPaySettings quickPaySettings, IQuickPayChecksumService quickPayChecksumService, string absoluteCancelUrl)
        {
            AbsoluteCancelUrl = absoluteCancelUrl;
            _quickPaySettings = quickPaySettings;
            _quickPayChecksumService = quickPayChecksumService;
        }

        public Dictionary<string, string> GetPostParams(string orderId, string language, decimal totalPrice, string currency, List<string> approvedPaymentMethods,
            string absoluteContinueUrl, string absoluteCallbackUrl)
        {
            var result = new Dictionary<string, string>
				             {
								 {"version", _quickPaySettings.Version}, //current the latest Quickpay protocol used
					             {"merchant_id", _quickPaySettings.Merchant},
					             {"agreement_id", _quickPaySettings.AgreementId},
								 {"order_id", orderId},
								 {"amount", ((int)(totalPrice * 100)).ToString(CultureInfo.InvariantCulture)}, //transfered as cents
								 {"currency", currency},
								 {"continueurl", absoluteContinueUrl},//great succes (receipt page)
					             {"cancelurl", AbsoluteCancelUrl},//user cancel
					             {"callbackurl", absoluteCallbackUrl}, //process ordre
								 {"language", language},
								 {"branding_id", ""},
								 {"category", ""},
								 {"product_id", ""},
								 {"reference_title", ""},
								 {"google_analytics_client_id", ""},
								 {"google_analytics_tracking_id", ""},
								 {"subscription", "0"},
								 {"description", ""},
								 {"payment_methods", approvedPaymentMethods != null && approvedPaymentMethods.Count > 0 
									? string.Join(",", approvedPaymentMethods) 
									: ""},

								 {"autofee", _quickPaySettings.AutoAddCardFee ? "1" : "0"},
								 {"autocapture", _quickPaySettings.AutoCapture ? "1" : "0"},
				             };

            result.Add("checksum", _quickPayChecksumService.Sign(result, _quickPaySettings.PublicApiKey));

            return result;
        }
    }
}
