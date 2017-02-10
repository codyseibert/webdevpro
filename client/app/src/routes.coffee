module.exports = [
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  (
    $stateProvider
    $urlRouterProvider
    $locationProvider
  ) ->

    $urlRouterProvider.otherwise '/courses'

    $locationProvider.html5Mode enabled: true, requireBase: false
    $locationProvider.hashPrefix '!'

    $stateProvider
      .state 'courses',
        url: '/courses'
        views:
          'main':
            controller: 'CoursesCtrl'
            templateUrl: 'courses/courses.html'

      .state 'courses.show',
        url: '/:shortName'
        views:
          'main@':
            controller: 'MainCtrl'
            templateUrl: 'main/main.html'

      .state 'courses.show.page',
        url: '/:title'
        views:
          'content@courses.show':
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
