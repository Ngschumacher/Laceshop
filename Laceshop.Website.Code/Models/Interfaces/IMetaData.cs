using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Laceshop.Models.Interfaces
{
    public interface IMetaData
    {
        string MetaTitle { get; }

        string MetaDescription { get; }

        string MetaKeywords { get; }

        string CanonicalUrl { get; }

        string AbsoluteUrl { get; }
    }
}