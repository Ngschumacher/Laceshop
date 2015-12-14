using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Helpers
{
    public static class EnumerableHelper
    {
        public static bool IsAndAny<T>(this IEnumerable<T> source)
        {
            return source != null && source.Any();
        }
    }
}
