var App;
(function (App) {
    var BasketComponentController = (function () {
        function BasketComponentController(basketService) {
            var _this = this;
            this.basketService = basketService;
            var response = basketService.getBasket();
            response.then(function (response) {
                _this.basket = response;
            });
        }
        BasketComponentController.$inject = ['basketService'];
        return BasketComponentController;
    }());
    var BasketComponent = (function () {
        function BasketComponent() {
            this.bindings = {};
            this.controller = BasketComponentController;
            this.templateUrl = '/Templates/basket.html';
        }
        return BasketComponent;
    }());
    var moduleApp = angular.module('storeApp');
    //angular.module('storeApp').service('basketService', BasketService);
    moduleApp.component('basket', new BasketComponent());
})(App || (App = {}));
//# sourceMappingURL=basket.component.js.map