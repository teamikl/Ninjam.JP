'use strict';

var gulp = require('gulp'),
    jade = require('gulp-jade'),
    less = require('gulp-less'),
    coffee = require('gulp-coffee'),
    gzip = require('gulp-gzip'),
    util = require('gulp-util'),
    // debug = require('gulp-debug'),
    plumber = require('gulp-plumber'),
    ftp = require('vinyl-ftp'),
    rimraf = require('rimraf'),
    uglify = require('gulp-uglify'),
    cssmin = require('gulp-cssmin'),
    browsersync = require('browser-sync');

var DIST_DIR = "./dist/";


// Jade コンパイル
gulp.task('jade', function(){
    return gulp.src(['src/jade/*.jade'])
        .pipe(plumber())
        .pipe(jade())
        .pipe(gulp.dest(DIST_DIR));
});


// Less コンパイル
gulp.task('less', function(){
    return gulp.src(['src/less/*.less'])
        .pipe(plumber())
        .pipe(less())
        .pipe(cssmin())
        .pipe(gulp.dest(DIST_DIR));
});


// Coffee コンパイル
gulp.task('coffee', function(){
    return gulp.src(['src/coffee/*.coffee'])
        .pipe(plumber())
        .pipe(coffee())
        .pipe(uglify())
        .pipe(gulp.dest(DIST_DIR));
});

gulp.task('compile:all', ['jade', 'less', 'coffee']);


// その他のファイル
gulp.task('others', function(){
    return gulp.src(
        ['src/others/*', 'src/others/.htaccess', 'src/others/img/*'],
        { base: 'src/others' }
    )
        .pipe(gulp.dest(DIST_DIR));
});


// ファイル圧縮
// 依存: jade, less, coffee
gulp.task('compress:dist', ['compile:all'], function(){
    return gulp.src(['./dist/*.html', './dist/*.css', './dist/*.js'])
        // .pipe(debug())
        .pipe(gzip())
        .pipe(gulp.dest(DIST_DIR));
});


// 生成されるファイルを削除
gulp.task('clean:dist', function(callback){
    rimraf('./dist/*', callback);
});


// browsersync
gulp.task('browser-sync', function(){
    browsersync({
        server: {
            baseDir: "./dist/"
        }
    });
});


  //ブラウザをリロード
  gulp.task('browser-reload', function(){
        browsersync.reload();
  });


// ファイルを公開
// 依存: build
gulp.task('deploy', ['compress:dist', 'others'], function(){
    var pit = require('pit-ro');

    // 設定ファイルを記述する(Pitで管理)
    // @see https://www.npmjs.com/package/pit-ro
    pit.pitDir = '/home/leo/Dropbox/web/www.ninjam.jp/.pit';
    var config = pit.get('ftp.ninjam.jp', 'config');

    var conn = ftp.create({
        host: config.host,
        user: config.user,
        password: config.password,
    });

    return gulp.src(['./dist/**','./dist/.htaccess'], {buffer: false})
        .pipe(conn.dest(config.upload_path));
});

// ファイル監視
gulp.task('watch', function(){
    gulp.watch('src/jade/*.jade', ['jade']);
    gulp.watch('src/jade/components/*.jade', ['jade']);
    gulp.watch('src/less/*.less', ['less']);
    gulp.watch('src/less/components/*.less', ['less']);
    gulp.watch('src/coffee/*.coffee', ['coffee']);
    gulp.watch('dist/**', ['browser-reload']);
});


// デフォルトで実行されるタスク
gulp.task('default', ['jade', 'less', 'coffee', 'watch', 'browser-sync']);
