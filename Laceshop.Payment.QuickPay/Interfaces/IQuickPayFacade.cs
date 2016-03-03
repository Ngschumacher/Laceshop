using System.Collections.Generic;

namespace Laceshop.Payment.QuickPay.Interfaces
{
    public interface IQuickPayFacade
    {
        Dictionary<string, string> GetPostParams(string orderId, string language, decimal totalPrice, string currency, List<string> approvedPaymentMethods,
            string absoluteContinueUrl, string absoluteCallbackUrl);
        string AbsoluteCancelUrl { get; set; }
    }
}
