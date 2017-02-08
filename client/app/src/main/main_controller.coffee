module.exports = [
  '$scope'
  '$state'
  '$stateParams'
  'lodash'
  'CoursesService'
  '$location'
  (
    $scope
    $state
    $stateParams
    _
    CoursesService
    $location
  ) ->


    CoursesService.then (courses) ->
      course = courses[0]
      $scope.modules = course.modules

    $scope.save = ->
      CourseService.put course

    $scope.deleteModule = (module) ->
      y = confirm 'are you sure you want to delete this module?'
      $scope.modules.splice $scope.modules.indexOf(module) 1 if y is true
      $scope.save() if y is true

    $scope.deleteTopic = (module, topic) ->
      y = confirm 'are you sure you want to delete this topic?'
      module.topics.splice module.topics.indexOf(topic) 1 if y is true
      $scope.save() if y is true

    $scope.deleteLesson = (topic, lesson) ->
      y = confirm 'are you sure you want to delete this lesson?'
      topic.lessons.splice topic.lessons.indexOf(lesson) 1 if y is true
      $scope.save() if y is true

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

    $scope.page = $stateParams.page or 'intro'

    $scope.pages =
      'intro':
        title: 'Intro'
        next: 'workspace'
        markdown: """

          ### Welcome to WebDevPro!

          We have created a complete course for teaching coders all the necessities to becoming a professional web developer.  After finishing our course, we promise you'll be able to understand how to create your very own web applications from scratch after completing our course.

          First, let's outline how this course works.  This course is compirsed of **modules**, **topics**, and **lessons**:

          ### Module
          **Modules** are a collection of topics and lessons which focus on a particular section of the web development stack.  It is not necessary to finish every lesson in the module before moving onto a new module.  Depending on your incoming experience level, some modules might be less useful to you than others.

          ### Topic
          A module is broken down into **topics**.  Each topic will cover an important tool, algorithm, design pattern, of piece of information which is too large to be considered a lesson.

          ### Lesson
          Lessons are the meat and potatoes of this course.  Each topic contains multiple lessons which build upon each other.  You can skip lessons as needed, but remember we recommend you finish the lessons in sequential order.

          Right, so let's get started!
        """
      'workspace':
        title: 'Workspace'
        next: 'ide'
        previous: 'intro'
        markdown: """
          In this module, **Workspace**, we will discuss a variety of tools which are used in the day to day by web developers.  We understand that there is a lot of stuff, and we do not expect you to become an expert overnight.  The main takeway from this module is that you have a basic understanding of these tools so that you can start to use them in your day to day as well.

          As a web developer, you will need to learn about the following:

          ### The IDE
          An IDE stands for Interactive Development Environment.  In short, it is a text editor.  This tool will become your most important one since writing, viewing, and editing code is the building blocks of becoming a web developer.

          Most IDE's contain a folder browser and a text editing panel with tabs.  Since this may be complicated for a first time user, we will first teach the basics of using a simple editor such as Notepad++ in this topic, and then discuss move verbose IDE's such as Atom and Vim.

          ### The Terminal
          It's not that scary, we promise.

          The terminal is also critical to learn.  Granted, you can hit the ground running without learning much about the terminal, but the earlier you get your hands dirty using this amazing tool, the quicker a proficient web developer you will become.  This tool is used for running commands, such as building your project, copying files to a remote server, connecting to a remote server, etc.

          ### The Chrome Web Browser
          But of course, how else would we do **WEB** develoment without a browser?  Front end development is a large portion of web development.  The chrome browser is one of many browsers a web developer should become familiar with in order to not only view their application, but to help debug, run analytics, collect logs, etc.

          ### Version Control (Git)
          We assume you'd like to start creating a portfolio to share your work and what you've learned.  Well, Git is just the tool for that.

          Git is a tool used for keeping track of your work.  As you make changes to your application, there will be times where you want to revert back to a previous version of your work, or fork off your current work to try with something new. Git can be used to intergate with amazing services such as GitHub or BitBucket so that anyone in the world can use your code.
        """
      'ide':
        title: 'IDE'
        next: 'notepad++'
        previous: 'workspace'
        markdown: """
          The first topic of this module is about IDE's.

          An IDE stands for Interactive Development Environment.  In short, it is a text editor.  This tool will become your most important one since writing, viewing, and editing code is the building blocks of becoming a web developer.

          Most IDEs have built in keyboard shortcuts which faciliate your ability to do simple tasks quickly.  For instance, deleting a line of code, copying a line of code, copying a line, commenting out blocks of code, uncommenting out blocks of code.  We recommend you start to learn these shortcuts as soon as possible so that you waste less time writing code.

          Things to become proficent in:

          - finding particular pieces of text quickly
          - file management (switching between files, opening files, closing files)
          - copying and pasting text
          - replacing text
          - commenting and uncommenting blocks of code
          - deleting lines of code
          - cutting lines of code
          - copying a line of code
          - pasting a line of code
        """

    return this
]
