
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

    course = null

    $scope.isAdmin = AdminService.password?

    $scope.shortName = $stateParams.shortName

    findByTitle = (courses, shortName, title) ->
      for course in courses
        if course.shortName is shortName
          for module in course.modules
            if module.title is title
              return module
            for topic in module.topics
              if topic.title is title
                return topic
              for lesson in topic.lessons
                if lesson.title is title
                  return lesson
      return null

    findCourse = (courses, shortName) ->
      for course in courses
        if course.shortName is shortName
          return course
      return null

    flatten = (modules) ->
      arr = []
      for module in modules
        arr.push module
        for topic in module.topics
          arr.push topic
          for lesson in topic.lessons
            arr.push lesson
      return arr

    $scope.save = ->
      CourseService.put course

    CoursesService.then (courses) ->
      shortName = $stateParams.shortName
      title = $stateParams.title

      course = findCourse courses, shortName
      $scope.obj = findByTitle courses, shortName, title

      flat = flatten course.modules

      for i in [0...flat.length-1]
        item = flat[i]
        item.next = flat[i+1].title
        if i > 0
          item.previous = flat[i-1].title

    return this
]
