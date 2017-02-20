express = require 'express'
bodyParser = require 'body-parser'
cors = require 'cors'
log4js = require 'log4js'
expressVue = require 'express-vue'
path = require 'path'
_ = require 'lodash'

models = require './models/models'
Courses = models.Courses
ObjectId = require('mongoose').Types.ObjectId

marked = require 'marked'

# module.exports = do ->
#   logger = log4js.getLogger 'app'
#   app = express()
#   app.use log4js.connectLogger(logger, level: log4js.levels.INFO)
#   app.use bodyParser.json()
#   app.use cors
#     origin: '*'
#   app

module.exports = do ->
  logger = log4js.getLogger 'app'
  app = express()
  app.use log4js.connectLogger(logger, level: log4js.levels.INFO)
  app.use bodyParser.json()
  app.use cors
    origin: '*'
  app.set 'views', path.resolve __dirname + '/views'
  app.set 'view engine', 'pug'

  app.get '/', (req, res) ->
    res.redirect '/courses'

  app.get '/courses', (req, res) ->
    Courses.find(active: true).lean().then (courses) ->
      courses.forEach (course) -> course.link = "/courses/#{course.shortName}/Overview"
      res.render 'courses',
        title: 'WebDevPro - Free Courses'
        description: 'This page contains the list of all the free WebDevPro courses.  Each course is designed to teach web development using HTML, Javascript (JS), and CSS'
        courses: courses

  app.get '/courses/:courseShortName', (req, res) ->
    shortName = req.params.courseShortName
    Courses.find(shortName: req.params.courseShortName).then (course) ->
      console.log 'course', course
      res.redirect "/#{shortName}/Overview"

  app.get '/courses/:courseShortName/:pageTitle', (req, res) ->
    shortName = req.params.courseShortName
    pageTitle = req.params.pageTitle

    findByTitle = (modules, title) ->
      for module in modules
        if module.title is title
          return module
        for topic in module.topics
          if topic.title is title
            return topic
          for lesson in topic.lessons
            if lesson.title is title
              return lesson
      return null

    Courses.findOne(shortName: req.params.courseShortName).lean().then (course) ->
      course.modules?.forEach (module) ->
        module.link = "/courses/#{course.shortName}/#{module.title}"
        module.topics?.forEach (topic) ->
          topic.link = "/courses/#{course.shortName}/#{topic.title}"
          topic.lessons?.forEach (lesson) ->
            lesson.link = "/courses/#{course.shortName}/#{lesson.title}"

      flatten = (modules) ->
        arr = []
        for module in modules
          arr.push module
          for topic in module.topics
            arr.push topic
            for lesson in topic.lessons
              arr.push lesson
        return arr
      flat = flatten course.modules
      for i in [0...flat.length]
        item = flat[i]
        delete item.next
        delete item.previous
        if i+1 < flat.length
          item.next =
            title: flat[i+1].title
            link: "/courses/#{course.shortName}/#{flat[i+1].title}"
        if i > 0
          item.previous =
            title: flat[i-1].title
            link: "/courses/#{course.shortName}/#{flat[i-1].title}"

      page = findByTitle course.modules, pageTitle
      page.markdown = marked page.markdown
      res.render 'page',
        title: "WebDevPro - #{course.title}: #{page.title}"
        description: page.description
        page: page
        course: course

  app
