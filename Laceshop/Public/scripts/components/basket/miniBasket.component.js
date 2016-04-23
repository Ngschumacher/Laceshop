var App;
(function (App) {
    var MiniBasketComponentController = (function () {
        function MiniBasketComponentController(basketService) {
            this.basketService = basketService;
            this.basket = basketService.basket;
        }
        MiniBasketComponentController.$inject = ['basketService'];
        return MiniBasketComponentController;
    }());
    var MiniBasketComponent = (function () {
        function MiniBasketComponent() {
            this.bindings = {};
            this.controller = MiniBasketComponentController;
            this.templateUrl = '/Templates/miniBasket.html';
        }
        return MiniBasketComponent;
    }());
    var moduleApp = angular.module('storeApp');
    //angular.module('storeApp').service('basketService', BasketService);
    moduleApp.component('miniBasket', new MiniBasketComponent());
})(App || (App = {}));
//# sourceMappingURL=miniBasket.component.js.map