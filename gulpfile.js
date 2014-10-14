var gulp = require('gulp');
var coffee = require("gulp-coffee");
var gutil = require('gulp-util');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var changed = require('gulp-changed');
var rename = require("gulp-rename");
var watch = require('gulp-watch');

gulp.task("separate", function () {
    gulp.src(['./src/coffee/**/*.coffee'])
        //.pipe(changed("./src/js"))
        .pipe(sourcemaps.init())
        .pipe(coffee({bare: true}).on("error", gutil.log))
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest("./src/js"));
});

gulp.task("single", function () {
    gulp.src(['./src/coffee/**/*.coffee'])
        //.pipe(changed("./src/js"))//TODO (S.Panfilov) make only changed files update
        .pipe(concat("./src/app.src.coffee"))
        .pipe(rename({basename: "app"}))
        .pipe(gulp.dest("./"))
        .pipe(sourcemaps.init())
        .pipe(coffee({bare: true}).on("error", gutil.log))
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest("./"));
});

gulp.task("js", function () {
    gulp.start("separate");
    gulp.start("single");
});


gulp.task('watch',function(){
    gulp.src('./src/coffee/**/*.coffee')
        .pipe(watch('./src/coffee/**/*.coffee', function(files) {
            gulp.start("js");
        }))
});

gulp.task("default", function () { //TODO (S.Panfilov) watch
    gulp.start("js");
    gulp.start("watch");
});