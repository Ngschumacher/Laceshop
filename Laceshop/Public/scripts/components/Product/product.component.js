var App;
(function (App) {
    var ProductComponentController = (function () {
        function ProductComponentController(productService, basketService, $scope, $location) {
            var _this = this;
            this.productService = productService;
            this.basketService = basketService;
            this.$scope = $scope;
            this.$location = $location;
            this.amount = 1;
            this.basket = basketService.basket;
            var skuId = $location.search()["id"];
            var response = productService.getProduct(this.productKey, skuId);
            response.then(function (response) {
                _this.product = response;
                _this.product.VariantOptions.forEach(function (variantOptions) {
                    variantOptions.model = variantOptions.Options.filter(function (x) { return x.Selected; })[0].Key;
                });
                if (skuId !== "") {
                    var variantByUrl = _this.product.Variants.filter(function (x) { return x.SkuId === skuId; })[0];
                    if (variantByUrl !== undefined) {
                        _this.setVariant(variantByUrl);
                    }
                    else {
                        _this.update();
                    }
                }
                else {
                    _this.update();
                }
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
            this.imageUrls(variant.ImageUrls);
            this.variant = variant;
            this.$location.search("id", this.variant.SkuId);
            this.$scope.$broadcast('MediasliderCtrl:reset');
            this.amount = 1;
            this.amountMax = this.variant.InventoryCount;
        };
        ProductComponentController.prototype.imageUrls = function (imageUrls) {
            this.slides = imageUrls.concat(this.product.ImageUrls);
        };
        ProductComponentController.prototype.addToBasket = function () {
            var amount = this.amount;
            this.basketService.updateItem(this.variant.Key, amount);
            this.amount = 1;
        };
        ProductComponentController.$inject = ['productService', 'basketService', '$scope', '$location'];
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