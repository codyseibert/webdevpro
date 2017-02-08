mongoose = require 'mongoose'

Courses = require './courses'

models =
  Courses: mongoose.model 'Courses', Courses

module.exports = models
