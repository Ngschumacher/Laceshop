using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Merchello.Core;
using Merchello.Core.Gateways.Payment;
using Merchello.Core.Models;
using Merchello.Plugin.Payments.QuickPay;
using Merchello.Plugin.Payments.QuickPay.Models;
using Newtonsoft.Json;
using Umbraco.Core.Logging;
using Umbraco.Web.Mvc;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers.Checkout
{
    public class CallbackTestController : SurfaceController
    {
        public ActionResult Index()
        {
            return Content("hello world");
        }

        public ActionResult Callback(string id)
        {
            string str1 = this.Request.Headers["QuickPay-Checksum-SHA256"];
            Stream inputStream = this.Request.InputStream;
            inputStream.Seek(0L, SeekOrigin.Begin);
            string json = new StreamReader(inputStream).ReadToEnd();
            LogHelper.Info<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>((Func<string>)(() => "[BODY] : " + json));
            QuickPayProviderSettings providerSettings = ExtendedDataExtensions.GetProviderSettings(MerchelloContext.Current.Gateways.Payment.GetProviderByKey(Guid.Parse(Constants.ProviderId), true).ExtendedData);
            string str2 = this.Sign(json, providerSettings.PrivateKey);
            if (!str1.Equals(str2))
            {
                LogHelper.Warn<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>("Checksum did not compute : " + str1 + "\r\n" + json);
                throw new Exception("MD5 Check does not compute");
            }
            QuickPayResponseModel payResponseModel;
            try
            {
                payResponseModel = JsonConvert.DeserializeObject<QuickPayResponseModel>(json);
            }
            catch (Exception ex)
            {
                LogHelper.Error<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>("Unable to deserialize json from QuickPay callback", ex);
                return (ActionResult)new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (!payResponseModel.Accepted)
            {
                LogHelper.Info<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>("Payment not accepted by QuickPay", new Func<object>[0]);
                return (ActionResult)this.Content("Payment not accepted by QuickPay");
            }
            if (payResponseModel.Order_Id.StartsWith("test_"))
            {
                LogHelper.Warn<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>("QuickPay is in test mode. The payment provider is unable to identify the invoice to apply the payment to, since the order_id was returned as " + payResponseModel.Order_Id);
                return (ActionResult)this.Content("QuickPay Test Mode Detected");
            }
            IInvoice byInvoiceNumber = MerchelloContext.Current.Services.InvoiceService.GetByInvoiceNumber(int.Parse(payResponseModel.Order_Id));
            IPaymentGatewayMethod paymentGatewayMethod1 = Enumerable.SingleOrDefault<IPaymentGatewayMethod>(MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods(), (Func<IPaymentGatewayMethod, bool>)(x => x.PaymentMethod.ProviderKey == Guid.Parse(Constants.ProviderId)));
            if (paymentGatewayMethod1 == null)
            {
                StringBuilder stringBuilder = new StringBuilder();
                stringBuilder.AppendLine(string.Format("QuickPay PaymentGatewayMethod not found. Looked for provider with key {0}", (object)Constants.ProviderId));
                stringBuilder.AppendLine("Here is a list of the payment providers found:");
                foreach (IPaymentGatewayMethod paymentGatewayMethod2 in MerchelloContext.Current.Gateways.Payment.GetPaymentGatewayMethods())
                    stringBuilder.AppendLine(string.Format("Name: {0}, PaymentCode: {1}, Key: {2}, ProviderKey: {3}", (object)paymentGatewayMethod2.PaymentMethod.Name, (object)paymentGatewayMethod2.PaymentMethod.PaymentCode, (object)paymentGatewayMethod2.PaymentMethod.Key, (object)paymentGatewayMethod2.PaymentMethod.ProviderKey));
                LogHelper.Warn<Merchello.Plugin.Payments.QuickPay.Controllers.CallbackController>(stringBuilder.ToString());
            }
            ProcessorArgumentCollection args = new ProcessorArgumentCollection();
            args.Add(Constants.ExtendedDataKeys.PaymentCurrency, payResponseModel.Currency);
            args.Add(Constants.ExtendedDataKeys.PaymentAmount, Enumerable.Sum<QuickPayOperation>(Enumerable.Where<QuickPayOperation>((IEnumerable<QuickPayOperation>)payResponseModel.Operations, (Func<QuickPayOperation, bool>)(x => !x.Pending)), (Func<QuickPayOperation, int>)(x => x.Amount)).ToString("F0"));
            args.Add(Constants.ExtendedDataKeys.QuickpayPaymentId, payResponseModel.Id.ToString("F0"));
            Notification.Trigger("OrderConfirmation", (object)InvoiceExtensions.AuthorizePayment(byInvoiceNumber, paymentGatewayMethod1, args), (IEnumerable<string>)new string[1]
      {
        byInvoiceNumber.BillToEmail
      });
            return (ActionResult)this.Content("Hello QuickPay");
        }

        private string Sign(string Base, string apiKey)
        {
            Encoding utF8 = Encoding.UTF8;
            byte[] hash = new HMACSHA256(utF8.GetBytes(apiKey)).ComputeHash(utF8.GetBytes(Base));
            StringBuilder stringBuilder = new StringBuilder();
            for (int index = 0; index < hash.Length; ++index)
                stringBuilder.Append(hash[index].ToString("x2"));
            return stringBuilder.ToString();
        }

      
    }
}
