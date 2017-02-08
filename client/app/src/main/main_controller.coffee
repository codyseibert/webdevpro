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

    if $state.current.name is 'main'
      $state.go 'main.page', {title: 'Intro'}

    course = null

    CoursesService.then (courses) ->
      course = courses[0]
      $scope.modules = course.modules

    $scope.save = ->
      CourseService.put course

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
