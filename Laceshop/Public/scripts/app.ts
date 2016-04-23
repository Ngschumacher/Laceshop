

module App {
	class Config {
		$inject = ['$locationProvider'];
		constructor($locationProvider: ng.ILocationProvider) {
			$locationProvider.html5Mode(true);
		}
	}
	function config($locationProvider: ng.ILocationProvider): void {
		$locationProvider.html5Mode(true);
	}
	var angularModule = angular.module('storeApp', []);
	angularModule.config(config);
}





