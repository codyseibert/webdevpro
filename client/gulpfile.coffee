gulp = require 'gulp'
browserify = require 'gulp-browserify'
clean = require 'gulp-clean'
del = require 'del'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
sass = require 'gulp-sass'
ngTemplates = require 'gulp-ng-templates'
gulpIgnore = require 'gulp-ignore'
connect = require 'gulp-connect'
replace = require 'gulp-replace'
args = require('yargs').argv
modRewrite = require 'connect-modrewrite'
uglify = require 'gulp-uglify'
pump = require 'pump'


isProduction = args.env is 'production'

gulp.task 'clean', ->
  del.sync [ 'tmp', 'build', 'dist' ]

gulp.task 'fonts', ->
  gulp.src('node_modules/bootstrap/fonts/*')
    .pipe gulp.dest('dist/fonts')

  gulp.src('node_modules/font-awesome/fonts/*')
    .pipe gulp.dest('dist/fonts')

gulp.task 'copy', ['jade'], ->
  gulp.src('tmp/templates/index.html')
    .pipe gulp.dest('dist')
    .pipe connect.reload()

  gulp.src('app/assets/images/*')
    .pipe gulp.dest('dist/assets/images')

  gulp.src('app/assets/fonts/*')
    .pipe gulp.dest('dist/assets/fonts')

gulp.task 'jade', ->
  gulp.src 'app/src/**/*.jade'
    .pipe jade
      pretty: true
    .pipe gulp.dest 'tmp/templates'

gulp.task 'templates', ['jade'], ->
  gulp.src ['tmp/templates/**/*.html', '!tmp/templates/index.html']
    .pipe ngTemplates
      filename: 'templates.js'
      module: 'webdevpro'
      standalone: false
    .pipe gulp.dest 'dist'
    .pipe connect.reload()

gulp.task 'sass', ->
  gulp.src('app/src/app.sass')
    .pipe(sass().on('error', gutil.log))
    .pipe(gulp.dest('dist'))
    .pipe connect.reload()

gulp.task 'coffee', ['templates'], ->
  gulp.src('app/src/**/*.coffee')
    .pipe(coffee({bare: true})
    .on('error', gutil.log))
    .pipe(gulp.dest('tmp/js'))

gulp.task 'scripts', ['replace'], ->
  t = gulp.src('tmp/js/app.js')
    .pipe(browserify({}))
  if isProduction
    t = t.pipe(uglify())
  t.pipe(gulp.dest('dist'))
    .pipe connect.reload()

gulp.task 'replace', ['coffee'], ->
  if isProduction
    gulp.src(['tmp/js/app.js'])
      .pipe(replace('http://localhost:8081', 'http://webdevproapi.codyseibert.com'))
      .pipe(replace('webdevpro-dev', 'webdevpro-prod'))
      .pipe(gulp.dest('tmp/js'))

gulp.task 'connect', ->
  connect.server
    root: 'dist'
    livereload: true
    middleware: (connect, options) ->
      [
        modRewrite ['!\\.html|\\.otf|\\.jpg|\\.js|\\.svg|\\.ico|\\.ttf|\\.woff|\\.css|\\.png$ /index.html [L]']
      ]

gulp.task 'watch', ->
  gulp.watch 'app/src/index.jade', [
    'copy'
  ]

  gulp.watch ['app/src/**/*.jade', '!app/src/index.html'], [
    'templates'
  ]

  gulp.watch 'app/src/**/*.sass', [
    'sass'
  ]

  gulp.watch 'app/src/**/*.coffee', [
    'scripts'
  ]

  gulp.watch 'app/assets/**/*', [
    'copy'
  ]

gulp.task 'build', [
  'clean'
  'jade'
  'templates'
  'coffee'
  'replace'
  'scripts'
  'sass'
  'copy'
  'fonts'
]

gulp.task 'default', [
  'build'
  'connect'
  'watch'
]
