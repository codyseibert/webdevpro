models = require '../models/models'
Courses = models.Courses
ObjectId = require('mongoose').Types.ObjectId

module.exports = do ->

  index: (req, res) ->
    Courses.find().then (courses) ->
      res.status 200
      res.send courses

  show: (req, res) ->
    Courses.findById(req.params.id).then (course) ->
      res.status 200
      res.send course

  post: (req, res) ->
    course = req.body
    Courses.create(course).then (course) ->
      res.status 200
      res.send course

  put: (req, res) ->
    Courses.update(_id: new ObjectId(req.params.id), req.body).then (course) ->
      res.status 200
      res.send course
