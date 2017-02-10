module.exports = [
  '$scope'
  '$state'
  '$stateParams'
  'lodash'
  'CoursesService'
  'CourseService'
  '$location'
  (
    $scope
    $state
    $stateParams
    _
    CoursesService
    CourseService
    $location
  ) ->

    $scope.isAdmin = $location.search().password?

    $scope.isActive = (course) ->
      $scope.isAdmin or course.active

    $scope.courses = null

    CoursesService.then (courses) ->
      $scope.courses = courses

    return this
]
