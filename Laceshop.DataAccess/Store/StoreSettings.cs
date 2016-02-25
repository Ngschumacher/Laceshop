using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Interfaces;
using Merchello.Core.Models;
using Merchello.Core.Models.Interfaces;
using Merchello.Core.Services;

namespace Laceshop.DataAccess.Store
{
	public class StoreSettings : IStoreSettings
	{
		private readonly IStoreSettingService _storeSettingService;

		public StoreSettings(IStoreSettingService storeSettingService)
		{
			_storeSettingService = storeSettingService;
		}

		public ICurrency GetCurrecy()
		{
			var storeSetting = _storeSettingService.GetByKey(Merchello.Core.Constants.StoreSettingKeys.CurrencyCodeKey);
			return _storeSettingService.GetCurrencyByCode(storeSetting.Value);
		}

		public ICurrencyFormat GetCurrencyFormat(ICurrency currency)
		{
			return _storeSettingService.GetCurrencyFormat(currency);
		}
	}
}
