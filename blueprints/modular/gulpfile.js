const gulp = require("gulp");
const postcss = require("gulp-postcss");
const concat = require("gulp-concat");
const terser = require("gulp-terser");
const { globSync } = require("glob");
const tailwindPostcss = require("@tailwindcss/postcss");

const jsSourceV1 = [
  "source/libs/@1jquery/1.11.0/jquery.js",
  "source/libs/@2lodash/2.4.1-custom/lodash.js",
  "source/libs/ckeditor5/latest/**/*.js",
  "source/libs/cookieconsent/latest/**/*.js",
  "source/libs/jquery.cookie/latest/**/*.js",
  "source/libs/jquery.fancybox/latest/**/*.js",
  "source/libs/jquery.matchHeight/latest/**/*.js",
  "source/libs/jquery.platform/latest/**/*.js",
  "source/libs/jquery.raty-fa/latest/**/*.js",
  "source/libs/jquery.scrollTo/latest/**/*.js",
  "source/libs/jquery.tools/latest/**/*.js",
  "source/libs/jsrender/latest/**/*.js",
  "source/libs/layzysizes/latest/**/*.js",
  "source/libs/modernizr/latest/**/*.js",
  "source/libs/owl-carousel/latest/**/*.js",
  "source/libs/pickaday/latest/**/*.js",
  "source/libs/recaptcha/latest/**/*.js",
  "source/libs/scroll-history/latest/**/*.js",
  "source/libs/select2/latest/**/*.js",
  "source/libs/swiperjs/latest/**/*.js",
  "source/libs/torqueui/latest/js/**/*.js",
  "source/js/platform.js",
  "source/js/template.js",
  "source/js/angularjs/libs/angular-1.4.3/*.js",
  "source/js/angularjs/libs/angular-checklist-model.js",
  "source/js/angularjs/libs/angular-equalizer.js",
  "source/js/angularjs/libs/rzslider.dirty.js",
  "source/js/angularjs/app/*.js",
  "source/js/angularjs/modules/**/*.js",
  "modules/**/assets/js/*.js",
  "modules/widgets/**/assets/js/*.js",
];

const jsSourceV2 = [
  "source/libs/@1jquery/latest/jquery.js",
  "source/libs/@2lodash/latest/lodash.custom.js",
  "source/libs/ckeditor5/latest/**/*.js",
  "source/libs/cookieconsent/latest/**/*.js",
  "source/libs/jquery.cookie/latest/**/*.js",
  "source/libs/jquery.fancybox/latest/**/*.js",
  "source/libs/jquery.matchHeight/latest/**/*.js",
  "source/libs/jquery.platform/latest/**/*.js",
  "source/libs/jquery.raty-fa/latest/**/*.js",
  "source/libs/jquery.scrollTo/latest/**/*.js",
  "source/libs/jquery.tools/latest/**/*.js",
  "source/libs/jsrender/latest/**/*.js",
  "source/libs/layzysizes/latest/**/*.js",
  "source/libs/modernizr/latest/**/*.js",
  "source/libs/owl-carousel/latest/**/*.js",
  "source/libs/pickaday/latest/**/*.js",
  "source/libs/recaptcha/latest/**/*.js",
  "source/libs/scroll-history/latest/**/*.js",
  "source/libs/select2/latest/**/*.js",
  "source/libs/swiperjs/latest/**/*.js",
  "source/libs/torqueui/latest/js/**/*.js",
  "source/js/platform.js",
  "source/js/template.js",
  "source/js/angularjs/libs/latest/*.js",
  "source/js/angularjs/libs/angular-checklist-model.js",
  "source/js/angularjs/libs/angular-equalizer.js",
  "source/js/angularjs/libs/rzslider.dirty.js",
  "source/js/angularjs/app/*.js",
  "source/js/angularjs/modules/**/*.js",
  "modules/**/assets/js/*.js",
  "modules/widgets/**/assets/js/*.js",
];

function getOrderedFiles(patterns) {
  const seen = new Set();
  const out = [];
  for (const p of patterns) {
    const files = globSync(p, { cwd: __dirname, nodir: true });
    files.forEach((f) => {
      if (!seen.has(f)) {
        seen.add(f);
        out.push(f);
      }
    });
  }
  return out;
}

function tailwindTask() {
  return gulp
    .src("source/css/tailwind.css", { allowEmpty: true })
    .pipe(postcss([tailwindPostcss()]))
    .pipe(gulp.dest("assets/css"));
}

function cssLibsTask() {
  return gulp
    .src([
      "source/libs/*/latest/**/*.css",
      "source/js/angularjs/libs/*.css",
      "modules/**/assets/css/*.css",
      "modules/widgets/**/assets/css/*.css",
    ], { allowEmpty: true })
    .pipe(concat("libs.css"))
    .pipe(gulp.dest("assets/css"));
}

function jsConcatV1() {
  const files = getOrderedFiles(jsSourceV1);
  const src = files.length > 0 ? files : [];
  return gulp
    .src(src, { cwd: __dirname, allowEmpty: true })
    .pipe(concat("app.js"))
    .pipe(gulp.dest("assets/js"));
}

function jsConcatV2() {
  const files = getOrderedFiles(jsSourceV2);
  const src = files.length > 0 ? files : [];
  return gulp
    .src(src, { cwd: __dirname, allowEmpty: true })
    .pipe(concat("app.js"))
    .pipe(gulp.dest("assets/js/2.0.0"));
}

function jsMinifyTask() {
  return gulp
    .src(["assets/js/app.js", "assets/js/2.0.0/app.js"], { allowEmpty: true })
    .pipe(
      terser({
        ecma: 5,
        compress: { drop_console: true, drop_debugger: true },
        mangle: { reserved: ["$", "require", "export", "window", "platform"] },
      })
    )
    .pipe(gulp.dest((f) => f.base));
}

gulp.task("tailwind", tailwindTask);
gulp.task("css:libs", cssLibsTask);
gulp.task("jsConcatV1", jsConcatV1);
gulp.task("jsConcatV2", jsConcatV2);
gulp.task("js:concat", gulp.parallel("jsConcatV1", "jsConcatV2"));
gulp.task("js:minify", jsMinifyTask);

gulp.task(
  "build",
  gulp.series("tailwind", "css:libs", "js:concat", "js:minify")
);

gulp.task("watch", () => {
  gulp.watch(
    ["source/css/tailwind.css", "postcss.config.mjs"],
    gulp.series("tailwind")
  );
  gulp.watch(
    [
      "source/libs/**/*.css",
      "source/js/angularjs/libs/*.css",
      "modules/**/assets/css/*.css",
      "modules/widgets/**/assets/css/*.css",
    ],
    gulp.series("css:libs")
  );
  gulp.watch(
    [
      "source/js/**/*.js",
      "modules/**/assets/js/*.js",
      "modules/widgets/**/assets/js/*.js",
    ],
    gulp.series("js:concat", "js:minify")
  );
});

gulp.task("default", gulp.series("build"));
