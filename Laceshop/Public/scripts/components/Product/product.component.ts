module App {
    
    interface IProductComponentBindings {
        productKey: string;
        dataBinding: number;
        functionBinding: () => any;
    }

    interface IProductComponentController extends IProductComponentBindings {
        update(attribute: IVariantAttribute) : void;
    }

    class ProductComponentController implements IProductComponentController {

        public productKey: string;
        public dataBinding: number;
        public functionBinding: () => any;

        public amount : number = 1;
        public product : IProduct;
        public variant: IVariant;
        public slides : Array<string>;
        public basket : IBasket;



        static $inject = ['productService', 'basketService', '$scope'];
        constructor(private productService: IProductService, public basketService: IBasketService, private $scope : ng.IScope) {
            var response = productService.getProduct(this.productKey);
            response.then(response => {
                this.product = response;

                this.product.VariantOptions.forEach(variantOptions => {
                    variantOptions.model = variantOptions.Options.filter(x => x.Selected)[0].Key;
                });
                this.basket = basketService.basket;

                this.update();
            });
        }

        public update() {
            var variantsCount: number = this.product.VariantOptions.length;

            this.product.Variants.forEach(variant => {
                var matches: number = 0;
                variant.Attributes.forEach(attribute => {
                    this.product.VariantOptions.forEach(variantOptions => {
                        if (attribute.Value.Key === variantOptions.model) {
                            matches++;
                        }
                    });
                });
                if (matches === variantsCount) {
                    this.setVariant(variant);
                }
            });   
        }

        private setVariant(variant : IVariant) {
            this.slides = variant.ImageUrls.concat(this.product.ImageUrls);
            this.variant = variant;
            console.log("changed");
            this.$scope.$broadcast('MediasliderCtrl:reset');
        }

        public addToBasket() {
            var amount = this.amount;
            this.basketService.updateItem(this.variant.Key, amount);
            this.amount = 1;
        }
    }

    class ProductComponent implements ng.IComponentOptions {

        public bindings: any;
        public controller: any;
        public templateUrl: string;

        constructor() {
            this.bindings = {
                productKey: '@',
                //dataBinding: '<',
                //functionBinding: '&'
            
            };
            this.controller = ProductComponentController;
            this.templateUrl = '/Templates/product.html';

        }

    }

    var moduleApp = angular.module('storeApp');
    
    moduleApp.component('product', new ProductComponent());
}



