module.exports = [
  'lodash'
  '$http'
  '$q'
  'API_PATH'
  '$location'
  'AdminService'
  (
    _
    $http
    $q
    API_PATH
    $location
    AdminService
  ) ->

    index: (course) ->
      $http.get "#{API_PATH}/courses", course
        .then (response) ->
          response.data

    show: (courseId) ->
      $http.get "#{API_PATH}/courses/#{courseId}"
        .then (response) ->
          response.data

    put: (course) ->
      $http(
        method: 'PUT'
        url: "#{API_PATH}/courses/#{course._id}"
        headers:
          password: AdminService.password
        data: course
      ).then (response) ->
        response.data

    post: (course) ->
      $http(
        method: 'PUT'
        url: "#{API_PATH}/courses"
        headers:
          password: AdminService.password
        data: course
      ).then (response) ->
        response.data

]
