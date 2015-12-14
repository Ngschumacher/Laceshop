using Core.Interfaces.Basket;
using Core.Interfaces.Product;
using Laceshop.DataAccess.Basket;
using Laceshop.DataAccess.Product;
using Merchello.Core.Services;
using Merchello.Web;
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
            DynamicModuleUtility.RegisterModule(typeof(OnePerRequestHttpModule));
            DynamicModuleUtility.RegisterModule(typeof(NinjectHttpModule));
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
            kernel.Bind<IBasketRepository>().To<BasketRepository>();
            kernel.Bind<IProductRepository>().To<ProductRepository>();
        }      
    }
 
}
