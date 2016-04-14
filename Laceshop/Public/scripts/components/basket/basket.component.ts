module App {
    
    interface IBasketComponentBindings {
        textBinding: string;
        dataBinding: number;
        functionBinding: () => any;
    }

    interface IBasketComponentController extends IBasketComponentBindings {
    }

    class BasketComponentController implements IBasketComponentController {

        public textBinding: string;
        public dataBinding: number;
        public functionBinding: () => any;

        

        public basket : IBasket;
        public test: string;

        static $inject = ['basketService'];
        constructor(private basketService: IBasketService) {
            this.basket = basketService.basket;
        }

        


    }

    class BasketComponent implements ng.IComponentOptions {

        public bindings: any;
        public controller: any;
        public templateUrl: string;

        constructor() {
            this.bindings = {
                //textBinding: '@',
                //dataBinding: '<',
                //functionBinding: '&'
            
            };
            this.controller = BasketComponentController;
            this.templateUrl = '/Templates/basket.html';

        }

    }

    var moduleApp = angular.module('storeApp');
    
    //angular.module('storeApp').service('basketService', BasketService);
    moduleApp.component('basket', new BasketComponent());
}



