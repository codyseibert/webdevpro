module.exports = [
  '$scope'
  '$state'
  '$stateParams'
  'lodash'
  'CoursesService'
  'CourseService'
  '$location'
  'AdminService'
  (
    $scope
    $state
    $stateParams
    _
    CoursesService
    CourseService
    $location
    AdminService
  ) ->

    $scope.isAdmin = AdminService.password?

    $scope.isActive = (course) ->
      $scope.isAdmin or course.active

    $scope.courses = null

    CoursesService.then (courses) ->
      $scope.courses = courses

    return this
]
