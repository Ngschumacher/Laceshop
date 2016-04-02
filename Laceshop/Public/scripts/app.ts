//import Util = require("util");

//class NgcAppComponent {

//    public static selector = 'ngc-app';
//    public static template = `<div>{{ ctrl.message }}</div>`;

//    private message;

//    constructor( @Util.Inject('$log') private $log: angular.ILogService) {
//        this.$log.info('Hello Component!');
//        this.message = 'Some message to display';
//    }
//}

//console.log("hej");
//var phonecatApp = angular.module('storeApp', []);

//class CartController {
//    constructor($scope) {
//        $scope.tax = 20;
//        $scope.invoice = {
//            items: [{
//                qty: 1,
//                title: 'Tuscan urns',
//                cost: 14,
//                url: 'product1'
//            },
//                {
//                    qty: 1,
//                    title: 'Bosphorus bowls',
//                    cost: 28,
//                    url: 'product2'
//                },
//                {
//                    qty: 2,
//                    title: 'Langdon vases ',
//                    cost: 24,
//                    url: 'product3'
//                }
//            ]
//        };
//    }
//};
//phonecatApp.controller("CartController", new CartController)

module App {

    interface IBasketController {
        
    }

    class BasketController implements  IBasketController {

        private items : any;

        constructor() {
            this.items = [
                {
                    qty: 1,
                    title: 'Tuscan urns',
                    cost: 14,
                    url: 'product1'
                },
                {
                    qty: 1,
                    title: 'Bosphorus bowls',
                    cost: 28,
                    url: 'product2'
                },
                {
                    qty: 2,
                    title: 'Langdon vases ',
                    cost: 24,
                    url: 'product3'
                }
            ];
        }
    }
}


module App {

    interface ISomeComponentBindings {
        textBinding: string;
        dataBinding: number;
        functionBinding: () => any;
    }

    interface ISomeComponentController extends ISomeComponentBindings {
        add(): void;
    }

    class SomeComponentController implements ISomeComponentController {

        public textBinding: string;
        public dataBinding: number;
        public functionBinding: () => any;

        constructor() {
            this.textBinding = 'teeest';
            this.dataBinding = 0;
        }

        add(): void {
            this.functionBinding();
        }

    }

    class SomeComponent implements ng.IComponentOptions {

        public bindings: any;
        public controller: any;
        public templateUrl: string;

        constructor() {
            this.bindings = {
                textBinding: '@',
                dataBinding: '<',
                functionBinding: '&'
            };
            this.controller = SomeComponentController;
            this.templateUrl = '/Templates/some-component.html';
            console.log("hej");

        }

    }

    var angularModule = angular.module('storeApp', []);
    angularModule.component('someComponent', new SomeComponent());

}



