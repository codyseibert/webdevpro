app = require('angular').module 'webdevpro'

app.service 'CourseService', require './course_service'
app.service 'CoursesService', require './courses_service'
app.service 'AdminService', require './admin_service'
