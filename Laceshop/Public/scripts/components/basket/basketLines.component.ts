module App {
    

    //angular.module('storeApp', []).factory('basketService', [BasketService]);


    interface IBasketLinesComponentBindings {
        basket : IBasket;
        
    }

    interface IBasketLinesComponentController extends IBasketLinesComponentBindings {
    }

    class BasketLinesComponentController implements IBasketLinesComponentController {

        public basket: IBasket;

        static $inject = ['basketService'];

        constructor(private basketService: IBasketService) {
        }

        removeItem(id: string): void {
            var response = this.basketService.removeItem(id);

            response.then(response => {
                this.basket = response;
            });
        }
        quantityChanged(id: string, quantity: number) {
            var response = this.basketService.updateItem(id, quantity);

            response.then(response => {
                this.basket = response;
            });
        }
    }

    class BasketLinesComponent implements ng.IComponentOptions {

        public bindings: any;
        public controller: any;
        public templateUrl: string;

        constructor() {
            this.bindings = {
                //textBinding: '@',
                basket: '<',
                removeItem: '&'
            };
           console.log(this.bindings.items);
            this.controller = BasketLinesComponentController;
            this.templateUrl = '/Templates/basketLines.html';

        }

    }

    var moduleApp = angular.module('storeApp');
    
    //angular.module('storeApp').service('basketService', BasketService);
    moduleApp.component('basketLines', new BasketLinesComponent());
}



