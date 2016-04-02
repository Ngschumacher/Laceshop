var App;
(function (App) {
    var BasketLinesComponentController = (function () {
        function BasketLinesComponentController(basketService) {
            this.basketService = basketService;
        }
        BasketLinesComponentController.prototype.removeItem = function (id) {
            var _this = this;
            var response = this.basketService.removeItem(id);
            response.then(function (response) {
                _this.basket = response;
            });
        };
        BasketLinesComponentController.prototype.quantityChanged = function (id, quantity) {
            var _this = this;
            var response = this.basketService.updateItem(id, quantity);
            response.then(function (response) {
                _this.basket = response;
            });
        };
        BasketLinesComponentController.$inject = ['basketService'];
        return BasketLinesComponentController;
    }());
    var BasketLinesComponent = (function () {
        function BasketLinesComponent() {
            this.bindings = {
                //textBinding: '@',
                basket: '<',
                removeItem: '&'
            };
            console.log(this.bindings.items);
            this.controller = BasketLinesComponentController;
            this.templateUrl = '/Templates/basketLines.html';
        }
        return BasketLinesComponent;
    }());
    var moduleApp = angular.module('storeApp');
    //angular.module('storeApp').service('basketService', BasketService);
    moduleApp.component('basketLines', new BasketLinesComponent());
})(App || (App = {}));
//# sourceMappingURL=basketLines.component.js.map