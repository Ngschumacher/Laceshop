var App;
(function (App) {
    var BasketComponentController = (function () {
        function BasketComponentController(basketService) {
            this.basketService = basketService;
            this.basket = basketService.basket;
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