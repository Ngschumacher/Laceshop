using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Laceshop.Payment.QuickPay.Interfaces;

namespace Laceshop.Payment.QuickPay
{
    public class QuickPayChecksumHMACSHA256 : IQuickPayChecksumService
    {
        public string Sign(string requestContent, string secretKey)
        {
            var e = Encoding.UTF8;

            var hmac = new HMACSHA256(e.GetBytes(secretKey));
            byte[] b = hmac.ComputeHash(e.GetBytes(requestContent));

            var s = new StringBuilder();
            for (int i = 0; i < b.Length; i++)
            {
                s.Append(b[i].ToString("x2"));
            }

            return s.ToString();
        }

        public string Sign(Dictionary<string, string> @params, string secretKey)
        {
            var result = string.Join(" ", @params.OrderBy(c => c.Key).Select(c => c.Value).ToArray());
            var e = Encoding.UTF8;
            var hmac = new HMACSHA256(e.GetBytes(secretKey));

            byte[] b = hmac.ComputeHash(e.GetBytes(result));

            var s = new StringBuilder();

            for (int i = 0; i < b.Length; i++)
            {
                s.Append(b[i].ToString("x2"));
            }

            return s.ToString();
        }
    }
}
