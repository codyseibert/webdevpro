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

    $scope.shortName = $stateParams.shortName

    $scope.course = null

    CoursesService.then (courses) ->
      $scope.course = _.find courses, (c) ->
        c.shortName is $scope.shortName
      $scope.modules = $scope.course.modules
      if $state.current.name is 'courses.show'
        $state.go 'courses.show.page',
          shortName: $scope.shortName
          title: $scope.modules[0].title
      else
        refreshNav()

    refreshNav = ->
      path = $location.path()
      split = path.split('/')
      title = split[split.length - 1]

      return if not $scope.modules?

      for module in $scope.modules
        module.clicked = false
        if module.title is title
          module.clicked = true
        for topic in module.topics
          topic.clicked = false
          if topic.title is title
            topic.clicked = true
          for lesson in topic.lessons
            lesson.clicked = false
            if lesson.title is title
              lesson.clicked = true

    $scope.$watch ->
      $location.path()
    , (newValue, oldValue) ->
      refreshNav()

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
