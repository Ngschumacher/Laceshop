using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Laceshop.Models.Interfaces
{
    public interface ITitleLink
    {
        string Url { get; }

        string DisplayTitle { get; }

        int Id { get; }
    }
}