// gulpfile.js

var gulp = require('gulp');
var clean = require('gulp-clean');
var elm = require('gulp-elm');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');
var connect = require('gulp-connect');

// File paths
var paths = {
  dest: 'dist',
  elm: 'src/*.elm',
  static: 'src/*.{html,css}',
  purs:'output/**/*.js',
  js:'src/js/*.js',
  pursDest: 'dist/purs/',
  jsDest: 'dist/js'
};

// Init Elm
gulp.task('elm-init', elm.init);

// Compile Elm to HTML
gulp.task('elm', ['elm-init'], function(){
    return gulp.src(paths.elm)
        .pipe(plumber())
        .pipe(elm())
        .pipe(gulp.dest(paths.dest));
});

// Move static assets to dist
gulp.task('static', function() {
    return gulp.src(paths.static)
        .pipe(plumber())
        .pipe(gulp.dest(paths.dest));
});

// Move static assets to dist
gulp.task('jsmodules', function() {
    return gulp.src(paths.js)
        .pipe(plumber())
        .pipe(gulp.dest(paths.jsDest));
});

// Move purescript assets to dist
gulp.task('purs', function() {
    return gulp.src(paths.purs)
        .pipe(plumber())
        .pipe(gulp.dest(paths.pursDest));
});

// Watch for changes and compile
gulp.task('watch', function() {
    gulp.watch(paths.elm, ['elm']);
    gulp.watch(paths.static, ['static']);
});

// Local server
gulp.task('connect', function() {
    connect.server({
        root: 'dist',
        port: 3000
    });
});

//clean out trash before building
gulp.task('clean', function () {
    return gulp.src(paths.dest, {read: false})
        .pipe(clean());
});
// Main gulp tasks
gulp.task('build', ['elm', 'static', 'jsmodules', 'purs']);
gulp.task('default', ['connect', 'build', 'watch']);