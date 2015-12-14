using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Laceshop.Models;
using Laceshop.Models.Products;
using Zone.UmbracoMapper;

namespace Laceshop.Controllers
{
    public abstract class BaseSurfaceController<T> : BaseSurfaceController
            where T : BasePageViewModel, new()
    {
        protected BaseSurfaceController(IUmbracoMapper mapper)
            : base(mapper)
        {
        }
    }
}