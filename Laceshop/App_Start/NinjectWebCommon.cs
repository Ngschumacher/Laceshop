using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Dependencies;
using Core.Interfaces;
using Core.Interfaces.Basket;
using Core.Models.QuickPay;
using Laceshop.DataAccess.Basket;
using Laceshop.DataAccess.Store;
using Laceshop.Payment.QuickPay;
using Laceshop.Payment.QuickPay.Interfaces;
using Laceshop.Payment.QuickPay.Models;
using Laceshop.Website.Code;
using Merchello.Core.Checkout;
using Merchello.Core.Models;
using Merchello.Core.Persistence.Repositories;
using Merchello.Core.Services;
using Merchello.Web;
using Merchello.Web.CheckoutManagers;
using Ninject.Activation;
using Ninject.Parameters;
using Ninject.Syntax;
using Umbraco.Core;
using Umbraco.Core.Services;
using Umbraco.Web;
using Zone.UmbracoMapper;

[assembly: WebActivatorEx.PreApplicationStartMethod(typeof(Laceshop.App_Start.NinjectWebCommon), "Start")]
[assembly: WebActivatorEx.ApplicationShutdownMethodAttribute(typeof(Laceshop.App_Start.NinjectWebCommon), "Stop")]

namespace Laceshop.App_Start
{
    using System;
    using System.Web;

    using Microsoft.Web.Infrastructure.DynamicModuleHelper;

    using Ninject;
    using Ninject.Web.Common;

    public static class NinjectWebCommon
    {
        private static readonly Bootstrapper bootstrapper = new Bootstrapper();

        /// <summary>
        /// Starts the application
        /// </summary>
        public static void Start()
        {
            DynamicModuleUtility.RegisterModule(typeof (OnePerRequestHttpModule));
            DynamicModuleUtility.RegisterModule(typeof (NinjectHttpModule));
            bootstrapper.Initialize(CreateKernel);
        }

        /// <summary>
        /// Stops the application.
        /// </summary>
        public static void Stop()
        {
            bootstrapper.ShutDown();
        }

        /// <summary>
        /// Creates the kernel that will manage your application.
        /// </summary>
        /// <returns>The created kernel.</returns>
        private static IKernel CreateKernel()
        {
            var kernel = new StandardKernel();
            try
            {
                kernel.Bind<Func<IKernel>>().ToMethod(ctx => () => new Bootstrapper().Kernel);
                kernel.Bind<IHttpModule>().To<HttpApplicationInitializationHttpModule>();

                RegisterServices(kernel);
               GlobalConfiguration.Configuration.DependencyResolver = new NinjectResolver(kernel);

                return kernel;
            }
            catch
            {
                kernel.Dispose();
                throw;
            }
        }

        /// <summary>
        /// Load your modules or register your services here!
        /// </summary>
        /// <param name="kernel">The kernel.</param>
        private static void RegisterServices(IKernel kernel)
        {
            kernel.Bind<IUmbracoMapper>().To<UmbracoMapper>();
            //kernel.Bind<UmbracoContext>().ToMethod(x => UmbracoContext.Current).InSingletonScope();
            kernel.Bind<IProductService>().To<ProductService>();
            kernel.Bind<IProductVariantService>().To<ProductVariantService>();
            kernel.Bind<CustomerContext>().ToMethod(x => new CustomerContext(UmbracoContext.Current)).InSingletonScope();
            kernel.Bind<IMediaService>().ToMethod(c => ApplicationContext.Current.Services.MediaService).InSingletonScope();
            kernel.Bind<IStoreSettingService>().To<StoreSettingService>();
            kernel.Bind<IBasketRepository>().To<BasketRepository>();
            kernel.Bind<ShopHelper>().To<ShopHelper>();
            kernel.Bind<IStoreSettings>().To<StoreSettings>();

            kernel.Bind<IQuickPaySettings>().ToMethod(x => new QuickPaySettings(
                publicApiKey: "3bf703dca3002ed0b041eb4706e70fc2816fc7d15f28b67c69d23ba279bdf845",
                privateKey: "e8ee591154becc11e69bdf8ee793732e97e4dc3a4c81a7f0c432cafe2fb5879a",
                merchant: "12616",
                agreementId: "44267",
                providerUrl: "https://payment.quickpay.net",
                isTest: true,
                version: "v10",
                msgType: QuickPayMsgType.Authorize,
                autoCapture: false,
                autoAddCardFee: true,
                language: "dk"
                ));

            kernel.Bind<IQuickPayChecksumService>().To<QuickPayChecksumHMACSHA256>();

            kernel.Bind<IQuickPayFacade>().To<QuickPayFacade>();

            //kernel.Bind<IProductRepository>().To<ProductRepository>();
        }
    }
    public class NinjectScope : IDependencyScope
    {
        protected IResolutionRoot resolutionRoot;

        public NinjectScope(IResolutionRoot kernel)
        {
            resolutionRoot = kernel;
        }

        public object GetService(Type serviceType)
        {
            IRequest request = resolutionRoot.CreateRequest(serviceType, null, new Parameter[0], true, true);
            return resolutionRoot.Resolve(request).SingleOrDefault();
        }

        public IEnumerable<object> GetServices(Type serviceType)
        {
            IRequest request = resolutionRoot.CreateRequest(serviceType, null, new Parameter[0], true, true);
            return resolutionRoot.Resolve(request).ToList();
        }

        public void Dispose()
        {
            IDisposable disposable = (IDisposable)resolutionRoot;
            if (disposable != null) disposable.Dispose();
            resolutionRoot = null;
        }
    }
    public class NinjectResolver : NinjectScope, IDependencyResolver
    {
        private IKernel _kernel;
        public NinjectResolver(IKernel kernel)
            : base(kernel)
        {
            _kernel = kernel;
        }
        public IDependencyScope BeginScope()
        {
            return new NinjectScope(_kernel.BeginBlock());
        }
    }
}

