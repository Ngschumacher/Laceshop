using Core.Models.QuickPay;
using Laceshop.Payment.QuickPay.Interfaces;

namespace Laceshop.Payment.QuickPay.Models
{
    public class QuickPaySettings : IQuickPaySettings
    {
        public QuickPaySettings(string publicApiKey, string privateKey, string merchant, string agreementId, string providerUrl, bool isTest, string version, QuickPayMsgType msgType,
            bool autoCapture, bool autoAddCardFee, string language)
        {
            PublicApiKey = publicApiKey;
            PrivateKey = privateKey;
            Language = language;
            AutoAddCardFee = autoAddCardFee;
            AutoCapture = autoCapture;
            MsgType = msgType;
            Version = version;
            IsTest = isTest;
            ProviderUrl = providerUrl;
            Merchant = merchant;
            AgreementId = agreementId;
        }

        public string Merchant { get; private set; }
        public string ProviderUrl { get; private set; }
        public bool IsTest { get; private set; }
        public bool AutoCapture { get; private set; }
        public bool AutoAddCardFee { get; private set; }
        public string Version { get; private set; }
        public QuickPayMsgType MsgType { get; private set; }
        public string PublicApiKey { get; set; }
        public string PrivateKey { get; set; }
        public string Language { get; private set; }
        public string OrderId { get; set; }
        public string AgreementId { get; set; }
    }
}
