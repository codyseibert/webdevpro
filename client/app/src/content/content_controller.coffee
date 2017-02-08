
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

    course = null

    findByTitle = (course, title) ->
      for module in course.modules
        if module.title is title
          return module
        for topic in module.topics
          if topic.title is title
            return topic
          for lesson in topic.lessons
            if lesson.title is title
              return lesson

    $scope.save = ->
      CourseService.put course

    CoursesService.then (courses) ->
      course = courses[0]
      $scope.obj = findByTitle course, $stateParams.title

    return this
]
