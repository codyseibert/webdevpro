mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  active: Boolean
  title: String
  shortName: String
  modules: Array
