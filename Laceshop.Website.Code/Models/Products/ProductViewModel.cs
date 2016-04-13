using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using Core.Models.Commerce;
using Laceshop.Models.Products;
using Merchello.Web.Models.VirtualContent;
using Umbraco.Core.Models;

namespace Laceshop.Website.Code.Models.Products
{
    public class ProductPageViewModel : BasePageViewModel
    {
        public ProductDetail Product { get; set; }
        //public ProductDetail Product { get; set; }
        public List<IPublishedContent> Images { get; set; }
        public List<string> ImageUrls { get; set; }
        public List<VariantAttributeViewModel> VariantOptions { get; set; }
    }

    public class ProductViewModel
    {
        public ProductDetail Product { get; set; }
        public List<string> ImageUrls { get; set; }
        public List<VariantOptionViewModel> VariantOptions { get; set; }
        public List<VariantViewModel> Variants { get; set; }
    }

    public class VariantViewModel
    {
        public Guid Key { get; set; }
        public List<VariantAttributeViewModel> Attributes { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public List<string> ImageUrls { get; set; }
    }

    public class VariantAttributeViewModel
    {
        public Guid Key { get; set; }
        public string Name { get; set; }
        public AttributeOptionViewModel Value { get; set; }
    }

    public class AttributeViewModel
    {
        public Guid Key { get; set; }
        public string Name { get; set; }
        public List<OptionViewModel> Options { get; set; }
    }
    public class AttributeOptionViewModel
    {
        public string Name { get; set; }
        public Guid Key { get; set; }
        public bool Selected { get; set; }
    }

    public class OptionViewModel
    {
        public string Name { get; set; }
        public Guid Key { get; set; }
        public int SortOrder { get; set; }
        public bool Selected { get; set; }
    }

}