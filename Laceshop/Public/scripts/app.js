var App;
(function (App) {
    var Config = (function () {
        function Config($locationProvider) {
            this.$inject = ['$locationProvider'];
            $locationProvider.html5Mode(true);
        }
        return Config;
    }());
    function config($locationProvider) {
        $locationProvider.html5Mode(true);
    }
    var angularModule = angular.module('storeApp', []);
    angularModule.config(config);
})(App || (App = {}));
//# sourceMappingURL=app.js.map