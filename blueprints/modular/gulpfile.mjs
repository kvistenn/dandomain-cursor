import gulp from 'gulp';
import gulpSass from 'gulp-sass';
import * as dartSass from 'sass';
import cleanCSS from 'gulp-clean-css';
import postcss from 'gulp-postcss';
import concat from 'gulp-concat';
import terser from 'gulp-terser';
import rename from 'gulp-rename';

const sass = gulpSass(dartSass);

// PostCSS plugins
import tailwindcssPostcss from '@tailwindcss/postcss';
import autoprefixer from 'autoprefixer';

// Source definitions
const scssSource = 'source/scss/template.scss';
const scssOutput = 'assets/css/template.css';

// Vendor JS from node_modules (order matters: jQuery first, then plugins).
// Add/remove packages here and run `npm install <pkg>`; then rebuild.
const vendorJs = [
  'node_modules/jquery/dist/jquery.js',
  'node_modules/lodash/lodash.js',
  'node_modules/jquery.cookie/jquery.cookie.js',
  'node_modules/@fancyapps/fancybox/dist/jquery.fancybox.js',
  'source/js/jquery.platform.js',
  'node_modules/jsrender/jsrender.js',
  'node_modules/cookieconsent/build/cookieconsent.min.js'
];

// Theme JS (after vendor)
const themeJs = [
  'source/js/template.js'
];

const jsSource = [...vendorJs, ...themeJs];

// Vendor CSS for libs.css (from node_modules). Add paths to include more lib CSS.
const vendorCss = [
  'node_modules/@fancyapps/fancybox/dist/jquery.fancybox.css',
  'node_modules/cookieconsent/build/cookieconsent.min.css'
];

// SCSS compilation task (watch mode - with source comments)
function sassWatch() {
  return gulp.src(scssSource, { sourcemaps: true })
    .pipe(sass({
      outputStyle: 'expanded',
      sourceComments: true,
      includePaths: [
        './node_modules/',
        './source/scss/'
      ]
    }).on('error', sass.logError))
    .pipe(postcss([tailwindcssPostcss(), autoprefixer()]))
    .pipe(rename('template.css'))
    .pipe(gulp.dest('assets/css', { sourcemaps: '.' }));
}

// SCSS compilation task (build mode - without source comments)
function sassBuild() {
  return gulp.src(scssSource, { sourcemaps: false })
    .pipe(sass({
      outputStyle: 'expanded',
      sourceComments: false,
      includePaths: [
        './node_modules/',
        './source/scss/'
      ]
    }).on('error', sass.logError))
    .pipe(postcss([tailwindcssPostcss(), autoprefixer()]))
    .pipe(rename('template.css'))
    .pipe(gulp.dest('assets/css'));
}

// Libs CSS: concat vendor CSS from node_modules
function libsCss() {
  return gulp.src(vendorCss, { allowEmpty: true })
    .pipe(concat('libs.css'))
    .pipe(gulp.dest('assets/css'));
}

// CSS minification (template + libs)
function cssMin() {
  return gulp.src([
    'assets/css/template.css',
    'assets/css/libs.css'
  ])
    .pipe(cleanCSS({
      keepSpecialComments: 0
    }))
    .pipe(gulp.dest('assets/css'));
}

// JS concatenation and minification (watch mode)
function jsWatch() {
  return gulp.src(jsSource, { allowEmpty: true })
    .pipe(concat('template.js'))
    .pipe(terser({
      compress: false,
      mangle: false,
      format: {
        beautify: true,
        comments: true
      }
    }))
    .pipe(gulp.dest('assets/js'));
}

// JS concatenation and minification (build mode)
function jsBuild() {
  return gulp.src(jsSource, { allowEmpty: true })
    .pipe(concat('template.js'))
    .pipe(terser({
      compress: {
        drop_console: true
      },
      mangle: true,
      format: {
        comments: false
      }
    }))
    .pipe(gulp.dest('assets/js'));
}

// Watch task
function watchFiles() {
  gulp.watch('source/scss/**/*.{scss,sass}', sassWatch);
  gulp.watch('source/js/**/*.js', jsWatch);
}

// Build tasks (libs.css is built from node_modules, so run libsCss first)
const build = gulp.series(libsCss, sassBuild, cssMin, jsBuild);
const buildDev = gulp.series(libsCss, sassBuild, cssMin, jsWatch);

// Default task (watch mode)
const defaultTask = gulp.series(
  libsCss,
  gulp.parallel(sassWatch, jsWatch),
  watchFiles
);

// Export tasks
export { libsCss, sassWatch, sassBuild, cssMin, jsWatch, jsBuild, build, buildDev, watchFiles };
export default defaultTask;
