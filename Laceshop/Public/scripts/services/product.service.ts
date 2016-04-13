module App {
    export interface IProductService {
        getProduct(productKey : string): ng.IPromise<IProduct>;
    }

    export class ProductService implements IProductService {

        httpService: ng.IHttpService;
        handlerUrl: string;

        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        constructor(private $http : ng.IHttpService, private $q : ng.IQService) {
            console.log("product Constructor");
        }

        getProduct(productKey : string ): ng.IPromise<IProduct> {
            console.log(productKey);
            var deferred = this.$q.defer();
            this.$http.get("/Umbraco/api/product/getProduct?key=" + productKey ).then(response => {
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
     
    };

    angular.module('storeApp').service('productService', ProductService);
}