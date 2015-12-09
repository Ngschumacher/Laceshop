using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Laceshop.Models;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers
{
    public abstract class BaseRenderMvcController<T> : BaseRenderMvcController
            where T : BasePageViewModel, new()
    {
        protected BaseRenderMvcController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }
    }
}