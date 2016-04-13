module App {

    interface IMediasliderComponentBindings {
        //productKey: string;
        //dataBinding: number;
        //functionBinding: () => any;
        slides : Array<string>;
    }

    interface IMediasliderComponentController extends IMediasliderComponentBindings {

    }

    class MediasliderComponentController implements IMediasliderComponentController {

        public slides : Array<string>;

        public options = {
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
        public deboundTimer = null;
        public autoplay = null;
        public timer = null;
        public currentIndex = 0;
        public numOfItems = 0;
        public thumbsBumbOffsetIndex = 0;
        public lastJumpDirection = 1;
        public lastSwitchTime = Date.now();
        public lastTouchEnd = Date.now();
        public states = {
            show: false,
            boxAnimating: false,
            slideAnimating: false,
            moveListen: false
        };

        public temp = {
            baseTime: null,
            basePointX: null,
            baseX: null,
            allowClick: true,
            lastTouchClientX: null
        };
        public thumbCss = {};

        static $inject = ['$timeout'];

        constructor(public $timeout: ng.ITimeoutService) {
            console.log(this.slides);
        }

        private setAutoPlay(direction) {
            direction = (direction === undefined) ? this.lastJumpDirection : direction;
            if (this.options.autoplay) {
                if (this.timer !== undefined) {
                    this.$timeout.cancel(this.timer);
                }
                this.timer = this.$timeout(function () {
                    this.switchItem(direction);
                }, this.options.autoplaytime);
            }
        }

        private switchItem(direction, jump) {
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
    }
        private bumbThumbsOffset(direction, jump) {
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
        }
        private updateThumbsOffset() {
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
    }
    }

    class MediasliderComponent implements ng.IComponentOptions {

        public bindings: any;
        public controller: any;
        public templateUrl: string;

        constructor() {
            this.bindings = {
                slides: '<',
                //dataBinding: '<',
                //functionBinding: '&'

            };
            this.controller = MediasliderComponentController;
            this.templateUrl = '/Templates/mediaslider.html';

        }

    }

    var moduleApp = angular.module('storeApp');

    moduleApp.component('mediaslider', new MediasliderComponent());
}



