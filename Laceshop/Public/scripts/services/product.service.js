var App;
(function (App) {
    var ProductService = (function () {
        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        function ProductService($http, $q) {
            this.$http = $http;
            this.$q = $q;
            console.log("product Constructor");
        }
        ProductService.prototype.getProduct = function (productKey) {
            console.log(productKey);
            var deferred = this.$q.defer();
            this.$http.get("/Umbraco/api/product/getProduct?key=" + productKey).then(function (response) {
                deferred.resolve(response.data);
            }).catch(function (reason) {
                return deferred.reject(reason);
            });
            return deferred.promise;
            //var basket: IBasket = {
            //    name : "hej",
            //    totalBasketPrice : 200
            //};
            //return basket;
        };
        return ProductService;
    }());
    App.ProductService = ProductService;
    ;
    angular.module('storeApp').service('productService', ProductService);
})(App || (App = {}));
//# sourceMappingURL=product.service.js.map