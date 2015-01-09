phonecatApp = angular.module 'phonecatApp', [
  'ngRoute',
  'phonecatControllers'
]

phonecatApp.config ['$routeProvider',
  ($routeProvider) ->
    $routeProvider
      .when '/phones',
        templateUrl: 'partials/phone-list',
        controller: 'PhoneListCtrl'
      .when '/phones/:phoneId',
        templateUrl: 'partials/phone-detail'
        controller: 'PhoneDetailCtrl'
      .otherwise
        redirectTo: '/phones'
    return
]
