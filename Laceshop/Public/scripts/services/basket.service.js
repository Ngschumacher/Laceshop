var App;
(function (App) {
    var BasketService = (function () {
        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        function BasketService($http, $q) {
            this.$http = $http;
            this.$q = $q;
            console.log("basket Constructor");
        }
        BasketService.prototype.getBasket = function () {
            var deferred = this.$q.defer();
            this.$http.get("/Umbraco/api/basket/getbasket").then(function (response) {
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
        BasketService.prototype.updateItem = function (id, quantity) {
            var deferred = this.$q.defer();
            this.$http.post("/Umbraco/api/basket/UpdateItemQuantity", { 'id': id, 'quantity': quantity }).then(function (response) {
                deferred.resolve(response.data);
            }).catch(function (reason) {
                return deferred.reject(reason);
            });
            return deferred.promise;
        };
        BasketService.prototype.removeItem = function (id) {
            var deferred = this.$q.defer();
            this.$http.delete("/Umbraco/api/basket/RemoveItem?id=" + id).then(function (response) {
                deferred.resolve(response.data);
            }).catch(function (reason) {
                return deferred.reject(reason);
            });
            return deferred.promise;
        };
        return BasketService;
    }());
    App.BasketService = BasketService;
    ;
    angular.module('storeApp').service('basketService', BasketService);
})(App || (App = {}));
//# sourceMappingURL=basket.service.js.map