var App;
(function (App) {
    var ProductComponentController = (function () {
        function ProductComponentController(productService) {
            var _this = this;
            this.productService = productService;
            var response = productService.getProduct(this.productKey);
            response.then(function (response) {
                _this.product = response;
                console.log(_this.product);
                _this.product.VariantOptions.forEach(function (variantOptions) {
                    variantOptions.model = variantOptions.Options.filter(function (x) { return x.Selected; })[0].Key;
                });
                _this.update();
                console.log(_this.variant);
            });
        }
        ProductComponentController.prototype.update = function () {
            var _this = this;
            var variantsCount = this.product.VariantOptions.length;
            this.product.Variants.forEach(function (variant) {
                var matches = 0;
                variant.Attributes.forEach(function (attribute) {
                    _this.product.VariantOptions.forEach(function (variantOptions) {
                        if (attribute.Value.Key === variantOptions.model) {
                            matches++;
                        }
                    });
                });
                if (matches === variantsCount) {
                    _this.setVariant(variant);
                }
            });
        };
        ProductComponentController.prototype.setVariant = function (variant) {
            this.slides = variant.ImageUrls.concat(this.product.ImageUrls);
            this.variant = variant;
        };
        ProductComponentController.$inject = ['productService'];
        return ProductComponentController;
    }());
    var ProductComponent = (function () {
        function ProductComponent() {
            this.bindings = {
                productKey: '@',
            };
            this.controller = ProductComponentController;
            this.templateUrl = '/Templates/product.html';
        }
        return ProductComponent;
    }());
    var moduleApp = angular.module('storeApp');
    moduleApp.component('product', new ProductComponent());
})(App || (App = {}));
//# sourceMappingURL=product.component.js.map