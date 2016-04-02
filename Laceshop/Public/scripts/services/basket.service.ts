module App {
    export interface IBasketService {
        getBasket(): ng.IPromise<IBasket>;
        updateItem(id: string, quantity: number) : ng.IPromise<IBasket>;
        removeItem(id: string) : ng.IPromise<IBasket>;
    }

    export class BasketService implements IBasketService {

        httpService: ng.IHttpService;
        handlerUrl: string;

        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        constructor(private $http : ng.IHttpService, private $q : ng.IQService) {
            console.log("basket Constructor");
        }

        getBasket(): ng.IPromise<IBasket> {

            var deferred = this.$q.defer();
            this.$http.get("/Umbraco/api/basket/getbasket").then(response => {
                deferred.resolve(response.data);
            }).catch(reason =>
                    deferred.reject(reason)
            );

            return deferred.promise;
            //var basket: IBasket = {
            //    name : "hej",
            //    totalBasketPrice : 200
            //};
            //return basket;
        }
        updateItem(id: string, quantity: number) : ng.IPromise<IBasket> {

            var deferred = this.$q.defer();
            this.$http.post("/Umbraco/api/basket/UpdateItemQuantity", {'id' : id, 'quantity' : quantity }).then(response => {
                deferred.resolve(response.data);
            }).catch(reason =>
                deferred.reject(reason)
                );

            return deferred.promise;
        }

        removeItem(id: string): ng.IPromise<IBasket> {

            var deferred = this.$q.defer();
            this.$http.delete("/Umbraco/api/basket/RemoveItem?id="+id).then(response => {
                deferred.resolve(response.data);
            }).catch(reason =>
                deferred.reject(reason)
                );

            return deferred.promise;
        }

    };

    angular.module('storeApp').service('basketService', BasketService);
}