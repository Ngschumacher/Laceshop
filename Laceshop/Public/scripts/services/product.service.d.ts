declare module App {
    interface IProductService {
        getProduct(productKey: string, skuId: string): ng.IPromise<IProduct>;
    }
    class ProductService implements IProductService {
        private $http;
        private $q;
        httpService: ng.IHttpService;
        handlerUrl: string;
        constructor($http: ng.IHttpService, $q: ng.IQService);
        getProduct(productKey: string, skuId: string): ng.IPromise<IProduct>;
    }
}
