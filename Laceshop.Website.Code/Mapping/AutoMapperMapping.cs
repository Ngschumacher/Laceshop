using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using AutoMapper;
using Core.Models.Commerce;
using Laceshop.Website.Code.Models.Basket;
using Laceshop.Website.Code.Models.Checkout;
using Laceshop.Website.Code.Models.Order;
using Merchello.Core.Models;
using Merchello.Web.Models.ContentEditing;
using Merchello.Web.Workflow;
using Umbraco.Core.Persistence.Migrations.Upgrades.TargetVersionSevenThreeZero;
using Umbraco.Web;

namespace Laceshop.Website.Code.Mapping
{
    public static class AutoMapperMapping
    {
        /// <summary>
        /// Creates AutoMapper mapping definitions for mapping Merchello commerce classes to view model classes
        /// </summary>
        public static void CreateMaps()
        {
            var umbracoHelper = new UmbracoHelper(UmbracoContext.Current);



            Mapper.CreateMap<ProductDisplay, ProductDetail>()
                .ForMember(dest => dest.Options,
                    source => source.MapFrom(src => src.ProductOptions))
                .ForMember(dest => dest.HasVariantsWithPriceRange,
                source => source.MapFrom(src => src.ProductVariants.Any() && src.ProductVariants.Min(x => x.Price) < src.ProductVariants.Max(x => x.Price)));
            Mapper.CreateMap<ProductOptionDisplay, ProductDetail.Option>();
            Mapper.CreateMap<IEnumerable<ProductAttributeDisplay>, SelectList>()
                .ConstructUsing(x => new SelectList(x
                    .OrderBy(y => y.SortOrder)
                    .ToList(), "Key", "Name"));

            Mapper.CreateMap<IBasket, BasketDetail>()
                .ForMember(dest => dest.TotalProductPrice,
                           source => source.MapFrom(src => src.TotalBasketPrice));

            Mapper.CreateMap<Basket, BasketViewModel>();
            Mapper.CreateMap<ILineItem, BasketLineViewModel>();
            Mapper.CreateMap<BasketDetail.LineItem, BasketLineViewModel>();
            Mapper.CreateMap<ILineItem, BasketDetail.LineItem>()
                .ForMember(dest => dest.ProductPageUrl,
                           source => source.MapFrom(src => umbracoHelper.TypedContent(int.Parse(src.ExtendedData["umbracoContentId"])).Url));

            Mapper.CreateMap<IInvoice, InvoiceDetail>()
                .ForMember(dest => dest.InvoiceStatus,
                           source => source.MapFrom(src => src.InvoiceStatus.Name));
	        Mapper.CreateMap<IAddress, CheckoutPageViewModel>()
		        .ForMember(dest => dest.Address1, source => source.MapFrom(src => src.Address1))
		        .ForMember(dest => dest.Address2, source => source.MapFrom(src => src.Address2))
		        .ForMember(dest => dest.Email, source => source.MapFrom(src => src.Email))
		        .ForMember(dest => dest.City, source => source.MapFrom(src => src.Locality))
		        .ForMember(dest => dest.CustomerName, source => source.MapFrom(src => src.Name))
		        .ForMember(dest => dest.Telephone, source => source.MapFrom(src => src.Phone))
		        .ForMember(dest => dest.Postcode, source => source.MapFrom(src => src.PostalCode))
		        .ForMember(dest => dest.County, source => source.MapFrom(src => src.Region));

            Mapper.CreateMap<IInvoice, OrderViewModel>()
                .ForMember(dest => dest.Items,
                    source => source.MapFrom(src => src.ProductLineItems()))
                .ForMember(dest => dest.ShippingPirce,
                    source => source.MapFrom(src => src.TotalShipping()))
                .ForMember(dest => dest.TotalItemPrice,
                    source => source.MapFrom(src => src.TotalItemPrice()));

            Mapper.CreateMap<IInvoiceLineItem, OrderLineItemViewModel>();
        }
    }
}