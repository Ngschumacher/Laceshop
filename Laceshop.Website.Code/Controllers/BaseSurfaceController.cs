using Laceshop.Models.Products;
using Zone.UmbracoMapper;

namespace Laceshop.Website.Code.Controllers
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