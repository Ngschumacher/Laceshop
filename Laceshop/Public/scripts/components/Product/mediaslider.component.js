var App;
(function (App) {
    var MediasliderComponentController = (function () {
        function MediasliderComponentController($timeout, $scope) {
            var _this = this;
            this.$timeout = $timeout;
            this.$scope = $scope;
            this.options = {
                debug: false,
                loop: true,
                autoplay: false,
                autoplaytime: 5000,
                boxAnimationTime: 1500,
                swipeMinTime: 50,
                swipeMaxTime: 600,
                swipeMinDistance: 50,
                swipeMaxDistance: 1600,
                clickPreventTime: 100
            };
            this.deboundTimer = null;
            this.autoplay = null;
            this.timer = null;
            this.currentIndex = 0;
            this.numOfItems = 0;
            this.thumbsBumbOffsetIndex = 0;
            this.lastJumpDirection = 1;
            this.lastSwitchTime = Date.now();
            this.lastTouchEnd = Date.now();
            this.states = {
                show: false,
                boxAnimating: false,
                slideAnimating: false,
                moveListen: false
            };
            this.temp = {
                baseTime: null,
                basePointX: null,
                baseX: null,
                allowClick: true,
                lastTouchClientX: null
            };
            this.thumbCss = {};
            this.$scope.$on('MediasliderCtrl:reset', function () {
                console.log('MediasliderCtrl:reset');
                _this.switchItem(0, true);
            });
        }
        MediasliderComponentController.prototype.setAutoPlay = function (direction) {
            direction = (direction === undefined) ? this.lastJumpDirection : direction;
            if (this.options.autoplay) {
                if (this.timer !== undefined) {
                    this.$timeout.cancel(this.timer);
                }
                this.timer = this.$timeout(function () {
                    this.switchItem(direction);
                }, this.options.autoplaytime);
            }
        };
        MediasliderComponentController.prototype.switchItem = function (direction, jump) {
            console.log("switchItem");
            console.log("switchITemsdf");
            if (Date.now() - this.lastSwitchTime > 100) {
                direction = (direction === undefined) ? 1 : direction;
                jump = (jump === undefined) ? false : jump;
                this.$timeout.cancel(this.timer);
                var activeIndex = this.currentIndex;
                var newActiveIndex;
                if (jump) {
                    newActiveIndex = direction;
                    this.lastJumpDirection = newActiveIndex - this.currentIndex;
                }
                else {
                    if (this.options.loop) {
                        newActiveIndex = (activeIndex + direction) % this.numOfItems;
                    }
                    else {
                        newActiveIndex = activeIndex + direction;
                        if (newActiveIndex > (this.numOfItems - 1)) {
                            newActiveIndex = this.numOfItems - 1;
                        }
                    }
                }
                if (newActiveIndex < 0) {
                    if (this.options.loop) {
                        newActiveIndex = Math.abs(this.numOfItems + newActiveIndex);
                    }
                    else {
                        newActiveIndex = 0;
                    }
                }
                if (this.lastJumpDirection > 1) {
                    this.lastJumpDirection = 1;
                }
                if (this.lastJumpDirection < -1) {
                    this.lastJumpDirection = -1;
                }
                this.currentIndex = newActiveIndex;
                this.lastSwitchTime = Date.now();
                this.bumbThumbsOffset(this.currentIndex - 2, true);
                this.updateThumbsOffset();
                this.setAutoPlay(this.lastJumpDirection);
            }
        };
        MediasliderComponentController.prototype.bumbThumbsOffset = function (direction, jump) {
            direction = (direction === undefined) ? 1 : direction;
            jump = (jump === undefined) ? false : jump;
            if (jump) {
                this.thumbsBumbOffsetIndex = direction;
            }
            else {
                this.thumbsBumbOffsetIndex += direction;
            }
            if (this.thumbsBumbOffsetIndex < 0) {
                this.thumbsBumbOffsetIndex = 0;
            }
            if (this.thumbsBumbOffsetIndex > this.numOfItems - 5) {
                this.thumbsBumbOffsetIndex = this.numOfItems - 5;
            }
            this.updateThumbsOffset();
        };
        MediasliderComponentController.prototype.updateThumbsOffset = function () {
            //TODO
            //- Move 70 to parameter. Is magic number. Height of thumb + margin
            var offset = this.thumbsBumbOffsetIndex * 70;
            if (offset < 0) {
                offset = 0;
            }
            if (offset !== 0 && offset > (this.numOfItems - 5) * 70) {
                offset = (this.numOfItems - 5) * 70;
            }
            offset = offset * -1;
            var css = {
                '-moz-transform': 'translate(0%, ' + offset + 'px)',
                '-ms-transform': 'translate(0%, ' + offset + 'px)',
                '-webkit-transform': 'translate(0%, ' + offset + 'px)',
                'transform': 'translate(0%, ' + offset + 'px)'
            };
            this.thumbCss = css;
        };
        MediasliderComponentController.$inject = ['$timeout', '$scope'];
        return MediasliderComponentController;
    }());
    var MediasliderComponent = (function () {
        function MediasliderComponent() {
            this.bindings = {
                slides: '<',
            };
            this.controller = MediasliderComponentController;
            this.templateUrl = '/Templates/mediaslider.html';
        }
        return MediasliderComponent;
    }());
    var moduleApp = angular.module('storeApp');
    moduleApp.component('mediaslider', new MediasliderComponent());
})(App || (App = {}));
//# sourceMappingURL=mediaslider.component.js.map