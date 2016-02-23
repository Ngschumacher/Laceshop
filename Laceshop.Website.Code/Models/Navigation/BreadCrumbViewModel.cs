using System.Collections.Generic;

namespace Laceshop.Website.Code.Models.Navigation
{
    public class BreadCrumbViewModel
    {
        public MenuItemViewModel CurrentPage { get; set; }
        public IEnumerable<MenuItemViewModel> MenuItems { get; set; }
    }
}