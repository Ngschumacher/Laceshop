var App;
(function (App) {
    var BasketService = (function () {
        //constructor($http: ng.IHttpService) {
        //    this.httpService = $http;
        //}
        function BasketService($http, $q) {
            this.$http = $http;
            this.$q = $q;
            this._basket = {};
            console.log("basket Constructor");
            this.retriveBasket();
        }
        Object.defineProperty(BasketService.prototype, "basket", {
            get: function () {
                return this._basket;
            },
            set: function (basket) {
                this._basket = basket;
            },
            enumerable: true,
            configurable: true
        });
        BasketService.prototype.retriveBasket = function () {
            var _this = this;
            this.$http.get("/Umbraco/api/basket/getbasket").then(function (response) {
                _this._basket = angular.extend(_this._basket, response.data);
                ;
            }).catch(function (reason) {
                console.log("something went wrong", reason);
            });
            //var basket: IBasket = {
            //    name : "hej",
            //    totalBasketPrice : 200
            //};
            //return basket;
        };
        BasketService.prototype.updateItem = function (id, quantity) {
            var _this = this;
            this.$http.post("/Umbraco/api/basket/AddItem", { 'id': id, 'quantity': quantity }).then(function (response) {
                //this._basket = <IBasket>response.data;
                angular.extend(_this._basket, response.data);
                console.log(response.data);
                console.log(_this._basket);
            }).catch(function (reason) {
                console.log("something went wrong", reason);
            });
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