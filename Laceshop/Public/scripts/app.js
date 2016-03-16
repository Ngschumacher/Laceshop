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
var app;
(function (app) {
    var controllers;
    (function (controllers) {
        var BasketController = (function () {
            function BasketController() {
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
            return BasketController;
        }());
    })(controllers = app.controllers || (app.controllers = {}));
})(app || (app = {}));
var app;
(function (app) {
    var directives;
    (function (directives) {
        var SomeComponentController = (function () {
            function SomeComponentController() {
                this.textBinding = '';
                this.dataBinding = 0;
            }
            SomeComponentController.prototype.add = function () {
                this.functionBinding();
            };
            return SomeComponentController;
        }());
        var SomeComponent = (function () {
            function SomeComponent() {
                this.bindings = {
                    textBinding: '@',
                    dataBinding: '<',
                    functionBinding: '&'
                };
                this.controller = SomeComponentController;
                this.templateUrl = 'some-component.html';
            }
            return SomeComponent;
        }());
        angular.module('storeApp', []).component('someComponent', new SomeComponent());
    })(directives = app.directives || (app.directives = {}));
})(app || (app = {}));
//# sourceMappingURL=app.js.map