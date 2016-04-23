var App;
(function (App) {
    var ProductService = (function () {
        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        function ProductService($http, $q) {
            this.$http = $http;
            this.$q = $q;
        }
        ProductService.prototype.getProduct = function (productKey, skuId) {
            var deferred = this.$q.defer();
            this.$http.get("/Umbraco/api/product/getProduct?key=" + productKey + "&skuId=" + skuId).then(function (response) {
                deferred.resolve(response.data);
            }).catch(function (reason) {
                return deferred.reject(reason);
            });
            return deferred.promise;
        };
        return ProductService;
    }());
    App.ProductService = ProductService;
    ;
    angular.module('storeApp').service('productService', ProductService);
})(App || (App = {}));
//# sourceMappingURL=product.service.js.map