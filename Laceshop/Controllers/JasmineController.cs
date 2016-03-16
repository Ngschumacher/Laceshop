using System;
using System.Web.Mvc;

namespace Laceshop.Controllers
{
    public class JasmineController : Controller
    {
        public ViewResult Run()
        {
            return View("SpecRunner");
        }
    }
}
