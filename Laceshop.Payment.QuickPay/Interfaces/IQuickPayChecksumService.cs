using System.Collections.Generic;

namespace Laceshop.Payment.QuickPay.Interfaces
{
    public interface IQuickPayChecksumService
    {
        string Sign(string requestContent, string secretKey);
        string Sign(Dictionary<string, string> @params, string secretKey);
    }
}
