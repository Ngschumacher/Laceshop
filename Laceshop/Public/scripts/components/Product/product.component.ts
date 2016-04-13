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

        public product : IProduct;
        public variant: IVariant;
        public slides : Array<string>;


        static $inject = ['productService'];
        constructor(private productService: IProductService) {
            var response = productService.getProduct(this.productKey);
            response.then(response => {
                this.product = response;
                console.log(this.product);

                this.product.VariantOptions.forEach(variantOptions => {
                    variantOptions.model = variantOptions.Options.filter(x => x.Selected)[0].Key;
                });

                this.update();
                console.log(this.variant);
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



