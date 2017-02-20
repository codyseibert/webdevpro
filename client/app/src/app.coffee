window.$ = require 'jquery'
window.jQuery = require 'jquery'
require 'jquery-ui'
window.moment = require 'moment'
# window.hljs = require 'highlight.js'

angular = require 'angular'
require 'angular-scroll'
require 'angular-filter'
require 'angular-animate'
require 'angular-local-storage'
require 'ng-lodash'
require '../../node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls'
require '../../node_modules/textangular/dist/textAngular-rangy.min'
require '../../node_modules/textangular/dist/textAngular-sanitize.min'
require '../../node_modules/textangular/dist/textAngular.min'
require 'ng-file-upload'
require 'angular-marked'
require 'fullcalendar'
require 'angular-ui-calendar'
require '@iamadamjowett/angular-click-outside'
require 'angular-chart.js'
require 'angular-jwt'
require 'angular-dragdrop'


app = require('angular').module('webdevpro', [
  require 'angular-ui-router'
  require 'angular-resource'
  'ngAnimate'
  # 'ngDragDrop'
  'angular-click-outside'
  'textAngular'
  'duScroll'
  'angular.filter'
  'ngFileUpload'
  'LocalStorageModule'
  'ngLodash'
  'ui.bootstrap'
  'hc.marked'
  'ui.calendar'
  'chart.js'
  'angular-jwt'
  require 'angular-moment'
])

app.value 'duScrollDuration', 500
app.value 'duScrollOffset', 70

app.config require './routes'

app.config [
  'localStorageServiceProvider'
  'markedProvider'
  (
    localStorageServiceProvider
    markedProvider
  ) ->
    localStorageServiceProvider
      .setPrefix 'webdevpro-dev'

    markedProvider.setOptions
      gfm: true
      tables: true
      highlight: (code, lang) ->
        if lang
          hljs.highlight(lang, code, true).value
        else
          hljs.highlightAuto(code).value
]

require './services'
require './content'
require './courses'
require './main'
require './tos'
require './pp'

app.constant 'API_PATH', 'http://localhost:8081'

app.run [
  '$rootScope'
  '$location'
  'AdminService'
  (
    $rootScope
    $location
    AdminService
  ) ->

    locationSearch = null

    AdminService.password = $location.search().password

    $rootScope.$on "$stateChangeSuccess", (event, currentRoute, previousRoute) ->
      window.scrollTo 0, 0

]
