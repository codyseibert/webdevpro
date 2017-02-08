module.exports = [
  '$scope'
  '$state'
  '$window'
  'SecurityService'
  'TokenService'
  (
    $scope
    $state
    $window
    SecurityService
    TokenService
  ) ->

    return this
]
