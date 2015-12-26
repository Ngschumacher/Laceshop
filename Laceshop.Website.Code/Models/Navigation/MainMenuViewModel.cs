using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Laceshop.Models.Navigation
{
    public class MainMenuViewModel
    {
        public IEnumerable<MenuItemViewModel> MenuItems { get; set; }
    }
}