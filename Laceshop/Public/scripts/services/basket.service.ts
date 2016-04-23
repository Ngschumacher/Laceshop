module App {
    export interface IBasketService {
        basket : IBasket;
        updateItem(id: string, quantity: number);
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

            this.retriveBasket();
        }
        private _basket: IBasket = <IBasket>{};

        get basket(): IBasket {
            return this._basket;
        }
        set basket(basket: IBasket) {
            this._basket = basket;
        }

        private retriveBasket() {

            this.$http.get("/Umbraco/api/basket/getbasket").then(response => {
				
                this._basket = angular.extend(this._basket, response.data);;
            }).catch(reason => {
                    console.log("something went wrong", reason);
                }
                    
            );

            //var basket: IBasket = {
            //    name : "hej",
            //    totalBasketPrice : 200
            //};
            //return basket;
        }
        updateItem(id: string, quantity: number)  {

            this.$http.post("/Umbraco/api/basket/AddItem", { 'id': id, 'quantity': quantity }).then(response => {
                //this._basket = <IBasket>response.data;
                angular.extend(this._basket, response.data);
                console.log(response.data);
                console.log(this._basket);
            }).catch(reason => {
                    console.log("something went wrong", reason);
                });
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