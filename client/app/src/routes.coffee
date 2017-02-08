module.exports = [
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  (
    $stateProvider
    $urlRouterProvider
    $locationProvider
  ) ->

    $urlRouterProvider.otherwise '/'

    $locationProvider.html5Mode enabled: true, requireBase: false
    $locationProvider.hashPrefix '!'

    $stateProvider
      .state 'main',
        url: '/'
        views:
          'main':
            controller: 'MainCtrl'
            templateUrl: 'main/main.html'

      .state 'main.page',
        url: ':title'
        views:
          'content@main':
            controller: 'ContentCtrl'
            templateUrl: 'content/content.html'

      .state 'tos',
        url: '/tos'
        views:
          'main':
            controller: 'TOSCtrl'
            templateUrl: 'tos/tos.html'

      .state 'pp',
        url: '/pp'
        views:
          'main':
            controller: 'PPCtrl'
            templateUrl: 'pp/pp.html'

    return this
]
