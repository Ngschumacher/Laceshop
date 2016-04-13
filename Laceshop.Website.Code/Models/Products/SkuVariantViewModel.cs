using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Laceshop.Website.Code.Models.Products
{
    public class VariantOptionViewModel
    {
        public Guid Key { get; set; }
        public string Name { get; set; }
        public List<OptionViewModel> Options { get; set; }
        public bool ReloadData { get; set; }
    }
}
