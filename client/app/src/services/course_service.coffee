module.exports = [
  'lodash'
  '$http'
  '$q'
  'API_PATH'
  '$location'
  (
    _
    $http
    $q
    API_PATH
    $location
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
          password: $location.search().password
        data: course
      ).then (response) ->
        response.data

    post: (course) ->
      $http(
        method: 'PUT'
        url: "#{API_PATH}/courses"
        headers:
          password: $location.search().password
        data: course
      ).then (response) ->
        response.data

]
