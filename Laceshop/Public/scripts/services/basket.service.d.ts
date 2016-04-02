declare module App {
    interface IBasketService {
        getBasket(): ng.IPromise<IBasket>;
        updateItem(id: string, quantity: number): ng.IPromise<IBasket>;
        removeItem(id: string): ng.IPromise<IBasket>;
    }
    class BasketService implements IBasketService {
        private $http;
        private $q;
        httpService: ng.IHttpService;
        handlerUrl: string;
        constructor($http: ng.IHttpService, $q: ng.IQService);
        getBasket(): ng.IPromise<IBasket>;
        updateItem(id: string, quantity: number): ng.IPromise<IBasket>;
        removeItem(id: string): ng.IPromise<IBasket>;
    }
}
