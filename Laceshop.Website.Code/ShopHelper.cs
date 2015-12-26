using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Interfaces;
using Merchello.Core;
using Merchello.Core.Models;

namespace Laceshop.Website.Code
{
	public class ShopHelper
	{
		private readonly IStoreSettings _storesettings;

		public ShopHelper(IStoreSettings storesettings)
		{
			_storesettings = storesettings;
		}

		public string FormatPrice(decimal price)
		{
			// Try to get a currency format else use the pre defined one.
			var currency = _storesettings.GetCurrecy();
			var symbol = currency.Symbol;
			var format = _storesettings.GetCurrencyFormat(currency);


			return string.Format(format.Format, symbol, price);
		}
	}
}
