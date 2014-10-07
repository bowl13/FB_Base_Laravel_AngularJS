# include gulp
gulp           = require("gulp")

# include our plugins
sass           = require("gulp-sass")
shell          = require("gulp-shell")
plumber        = require("gulp-plumber")
notify         = require("gulp-notify")
minifycss      = require("gulp-minify-css")
autoprefixer   = require("gulp-autoprefixer")
concat         = require("gulp-concat")
rename         = require("gulp-rename")
uglify         = require("gulp-uglify")
coffee         = require("gulp-coffee")
cache          = require("gulp-cached")
clean          = require("gulp-clean")
imagemin       = require("gulp-imagemin")
browserSync    = require("browser-sync")
gulpStripDebug = require("gulp-strip-debug")
reload         = require("gulp-livereload")
templateCache  = require('gulp-angular-templatecache');
runSequence    = require('run-sequence');

# paths
src            = "src/"
dest           = "../public/"


SCRIPTS = [
  "bower_components/jquery/jquery.js"
  "bower_components/velocity/velocity.js"
  "bower_components/velocity/velocity.ui.js"
  "bower_components/angular/angular.js"
  "bower_components/angular-route/angular-route.js"
  "bower_components/angular-facebook/lib/angular-facebook.js"
  "bower_components/angulartics/src/angulartics.js"
  "bower_components/angulartics/src/angulartics-ga.js"
  "bower_components/angular-cookies/angular-cookies.js"
  "bower_components/angular-animate/angular-animate.js"
  src + "scripts/app.js"
  src + "scripts/controllers.js"
  src + "scripts/factory.js"
  src + "scripts/directives.js"
  src + "scripts/templates.js"
  src + "scripts/scripts.js"
]

#
# Dev task
# ====================
#

# clean
gulp.task "clean", ->
  gulp.src dest + 'assets/*'
  .pipe clean
    force: true

# copy images
gulp.task "images", ->
  gulp.src src + "images/**/*.*"
  .pipe gulp.dest dest + "assets/images"
  .pipe reload()

# copy and minify images
gulp.task "images-minify", ->
  gulp.src src + "images/**/*.*"
  .pipe imagemin
    progressive: true
  .pipe gulp.dest dest + "assets/images"

# copy templates
gulp.task "templates-php", ->
  gulp.src [
    src + "/template/*.php"
  ]
  .pipe gulp.dest "../app/views"

# copy templates and concat html
gulp.task "templates", ["templates-php"], ->
  gulp.src [
    src + "/html/partials/*.html"
  ]
  .pipe(templateCache('templates.js', { module:'templatescache', standalone:true }))
  .pipe gulp.dest dest + "assets/scripts"

# copy and concat js app
gulp.task "scripts", ->
  gulp.src SCRIPTS
  .pipe concat "scripts.js"
  .pipe gulp.dest dest + "assets/scripts"
  .pipe reload()

# copy and concat js app
gulp.task "scripts-dist", ->
  gulp.src SCRIPTS
  .pipe concat "scripts.js"
  .pipe uglify
    mangle: false
  .pipe gulp.dest dest + "assets/scripts"

# styles
gulp.task "styles", ->
  gulp.src src + "/styles/styles.scss"
  .pipe plumber()
  .pipe sass
    sourceComments: "normal"
    errLogToConsole: false
    onError: (err) -> notify().write(err)
  .pipe autoprefixer("last 15 version")
  .pipe gulp.dest dest + "/assets/styles"
  .pipe reload()

# styles-dist
gulp.task "styles-dist",  ->
  gulp.src src + "/styles/styles.scss"
  .pipe plumber()
  .pipe sass()
  .on "error", notify.onError()
  .on "error", (err) ->
    console.log "Error:", err
  .pipe autoprefixer("last 15 version")
  .pipe minifycss
    keepSpecialComments: 0
  .pipe gulp.dest dest + "/assets/styles"

# watch files
gulp.task 'watch', ->
  gulp.watch [src + '/scripts/*.js'], ['scripts']
  gulp.watch [src + '/html/**/*.html', src + '/template/*.php'], ['templates']
  gulp.watch [src + '/styles/**/*.scss'], ['styles']
  gulp.watch [src + '/images/**/*.*'], ['images']

#
#  defaul task
#  ==========================================================================

gulp.task "default", ["clean"], (cb) ->
  runSequence "styles", [
    "clean"
    "scripts"
    "images"
    "templates"
    "styles"
    "watch"
  ], cb

#
# dist task
# ====================
#

gulp.task "dist", ["clean"], (cb) ->
  runSequence "styles-dist", [
    "clean"
    "scripts-dist"
    "images-minify"
    "templates"
    "styles-dist"
  ], cb
