using Core.Models.QuickPay;

namespace Laceshop.Payment.QuickPay.Interfaces
{
    public interface IQuickPaySettings
    {
        /// <summary>
        /// The QuickPayId
        /// </summary>
        string Merchant { get; }

        /// <summary>
        /// QuickPay url
        /// </summary>
        string ProviderUrl { get; }

        /// <summary>
        /// Indicates of this is a test order
        /// </summary>
        bool IsTest { get; }

        /// <summary>
        /// If set to 1, the transaction will be captured automatically. 
        /// See http://quickpay.net/features/autocapture/ for more information. Note: autocapture is only valid for message type 'authorize' and 'recurring'
        /// </summary>
        bool AutoCapture { get; }

        /// <summary>
        /// If set to 1, the fee charged by the acquirer will be calculated and added to the transaction amount. See http://quickpay.net/features/transaction-fees/ for more information.
        /// </summary>
        bool AutoAddCardFee { get; }

        /// <summary>
        /// Defines the version of the protocol. 7 is the latest
        /// </summary>
        string Version { get; }

        /// <summary>
        /// Defines wether the transaction should be a standard payment or a subscription payment.
        /// Valid values are: authorize and subscribe
        /// </summary>
        QuickPayMsgType MsgType { get; }

        /// <summary>
        /// The language to use in the HTML pages as 2-letter ISO 639-1 alphabetical code. See http://quickpay.net/features/languages/ for supported languages.
        /// </summary>
        string Language { get; }

        string AgreementId { get; set; }

        string PublicApiKey { get; set; }

        string PrivateKey { get; set; }
    }
}
