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

    $scope.shortName = $stateParams.shortName

    $scope.course = null

    CoursesService.then (courses) ->
      $scope.course = _.find courses, (c) ->
        c.shortName is $scope.shortName
      $scope.modules = $scope.course.modules
      $state.go 'courses.show.page',
        shortName: $scope.shortName
        title: $scope.modules[0].title

    $scope.save = ->
      CourseService.put $scope.course

    $scope.deleteModule = (module) ->
      y = confirm 'are you sure you want to delete this module?'
      if y is true
        $scope.modules.splice $scope.modules.indexOf(module), 1
        $scope.save()

    $scope.deleteTopic = (module, topic) ->
      y = confirm 'are you sure you want to delete this topic?'
      if y is true
        module.topics.splice module.topics.indexOf(topic), 1
        $scope.save()

    $scope.deleteLesson = (topic, lesson) ->
      y = confirm 'are you sure you want to delete this lesson?'
      if y is true
        topic.lessons.splice topic.lessons.indexOf(lesson), 1
        $scope.save()

    $scope.newModule = ->
      $scope.modules.push
        title: ''
        markdown: ''
        editTitle: true
        topics: []
      $scope.save()

    $scope.newTopic = (module) ->
      module.topics ?= []
      module.topics.push
        title: ''
        markdown: ''
        editTitle: true
        lessons: []
      $scope.save()

    $scope.newLesson = (topic) ->
      topic.lessons ?= []
      topic.lessons.push
        title: ''
        markdown: ''
        editTitle: true
      $scope.save()

    return this
]
