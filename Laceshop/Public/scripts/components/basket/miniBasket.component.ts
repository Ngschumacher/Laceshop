module App {
    
    interface IMiniBasketComponentBindings {
        textBinding: string;
        dataBinding: number;
        functionBinding: () => any;
    }

    interface IMiniBasketComponentController extends IMiniBasketComponentBindings {
    }

    class MiniBasketComponentController implements IMiniBasketComponentController {

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

    class MiniBasketComponent implements ng.IComponentOptions {

        public bindings: any;
        public controller: any;
        public templateUrl: string;

        constructor() {
            this.bindings = {
                //textBinding: '@',
                //dataBinding: '<',
                //functionBinding: '&'
            
            };
            this.controller = MiniBasketComponentController;
            this.templateUrl = '/Templates/miniBasket.html';

        }

    }

    var moduleApp = angular.module('storeApp');
    
    //angular.module('storeApp').service('basketService', BasketService);
    moduleApp.component('miniBasket', new MiniBasketComponent());
}



