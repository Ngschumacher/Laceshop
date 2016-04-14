declare module App {
    interface IBasketService {
        basket: IBasket;
        updateItem(id: string, quantity: number): any;
        removeItem(id: string): ng.IPromise<IBasket>;
    }
    class BasketService implements IBasketService {
        private $http;
        private $q;
        httpService: ng.IHttpService;
        handlerUrl: string;
        constructor($http: ng.IHttpService, $q: ng.IQService);
        private _basket;
        basket: IBasket;
        private retriveBasket();
        updateItem(id: string, quantity: number): void;
        removeItem(id: string): ng.IPromise<IBasket>;
    }
}
