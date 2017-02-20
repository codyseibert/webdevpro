app = require './app'

CoursesCtrl = require './controllers/courses_controller'

isAdmin = require './helpers/is_admin'

module.exports = do ->

  # app.post '/login', LoginCtrl.post

  app.get '/api/courses', CoursesCtrl.index
  app.get '/api/courses/:id', CoursesCtrl.show
  app.post '/api/courses', isAdmin, CoursesCtrl.post
  app.put '/api/courses/:id', isAdmin, CoursesCtrl.put

  # app.post '/users', UsersCtrl.post
  # app.get '/users/:id', userIsLoggedIn, userOwnsUser, UsersCtrl.show
  # app.put '/users/:id', userIsLoggedIn, userOwnsUser, UsersCtrl.put
