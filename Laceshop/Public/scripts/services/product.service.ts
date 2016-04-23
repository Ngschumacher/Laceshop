module App {
    export interface IProductService {
        getProduct(productKey : string, skuId : string): ng.IPromise<IProduct>;
    }

    export class ProductService implements IProductService {

        httpService: ng.IHttpService;
        handlerUrl: string;

        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        constructor(private $http : ng.IHttpService, private $q : ng.IQService) {
        }

        getProduct(productKey: string, skuId: string): ng.IPromise<IProduct> {
            var deferred = this.$q.defer();
            this.$http.get("/Umbraco/api/product/getProduct?key=" + productKey +"&skuId=" + skuId ).then(response => {
                deferred.resolve(response.data);
            }).catch(reason =>
                    deferred.reject(reason)
            );	

            return deferred.promise;
        }
     
    };

    angular.module('storeApp').service('productService', ProductService);
}