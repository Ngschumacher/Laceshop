using System;
using Laceshop.Website.Code.Mapping;
using Umbraco.Web;

namespace Laceshop
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    //public class MvcApplication : System.Web.HttpApplication
    //{
    //    protected void Application_Start()
    //    {
    //        throw new ApplicationException("Yup, it fired");
    //        AutoMapperMapping.CreateMaps();
    //        AreaRegistration.RegisterAllAreas();
    //        WebApiConfig.Register(GlobalConfiguration.Configuration);
    //        FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
    //        RouteConfig.RegisterRoutes(RouteTable.Routes);
    //    }
    ////}
    public class Global : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            AutoMapperMapping.CreateMaps();

        }
    }
 
}