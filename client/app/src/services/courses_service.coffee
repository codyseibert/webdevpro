module.exports = [
  'CourseService'
  '$q'
  (
    CourseService
    $q
  ) ->

    # obj =
    #   course: null
    #
    # promise = CourseService.index()
    #   .then (courses) ->
    #     obj.course = courses[0]
    #
    # getCourse: promise.then ->
    #   $q (resolve, reject) ->
    #     resolve course

    CourseService.index()

]
