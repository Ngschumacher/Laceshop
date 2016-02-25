using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Merchello.Core.Models;
using Merchello.Core.Models.Interfaces;
using Merchello.Web.Models.ContentEditing;

namespace Core.Interfaces
{
	public interface IStoreSettings
	{
		ICurrency GetCurrecy();
		ICurrencyFormat GetCurrencyFormat(ICurrency currency);
	}

}
