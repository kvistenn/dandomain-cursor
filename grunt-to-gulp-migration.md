---
name: Grunt to Gulp Migration
overview: Migrate the build system from Grunt to Gulp 5 (ESM), replacing all Grunt tasks with equivalent Gulp tasks while preserving identical build outputs, source/watch patterns, and dev/production workflows.
todos:
  - id: create-gulpfile
    content: Create gulpfile.mjs with all task definitions (sass, cssmin, postcss/tailwind, concat, terser, rollup, watch) using ESM syntax
    status: completed
  - id: update-package-json
    content: "Update package.json: remove 11 Grunt packages, add 6 Gulp packages, update scripts and engines"
    status: completed
  - id: delete-gruntfile
    content: Delete gruntfile.js after Gulp setup is complete
    status: completed
  - id: install-and-verify
    content: Run npm install and verify gulp tasks execute correctly (user runs this)
    status: in_progress
isProject: false
---

# Grunt to Gulp 5 Migration

## Current State

The project uses Grunt (`gruntfile.js`) with 11 Grunt-specific packages to handle:

- SCSS compilation (3 entry points)
- CSS minification/concatenation (3 outputs)
- PostCSS/Tailwind processing
- JS concatenation (2 versioned bundles: v1.0.0 and v2.0.0)
- JS minification via Terser (dev + production modes)
- Rollup bundling (CheckoutKlarna module with Babel)
- File watching (4 watch targets with `atBegin: true`)

## Migration Strategy

Use **Gulp 5** with **ES Module syntax** (`gulpfile.mjs`). Gulp 5 supports ESM natively, uses async/await, and has built-in sourcemap support.

### Task Mapping

- `grunt-sass` --> `gulp-sass` + `sass` (Dart Sass)
- `grunt-contrib-cssmin` --> `gulp-clean-css`
- `grunt-postcss` --> `gulp-postcss`
- `grunt-contrib-concat` --> `gulp-concat`
- `grunt-terser` --> `gulp-terser`
- `grunt-rollup` --> `rollup` direct API (async task, as recommended by Gulp docs)
- `grunt-contrib-watch` --> `gulp.watch()` (built-in)
- `grunt-env`, `load-grunt-tasks` --> not needed

### Exported Gulp Tasks


| Task           | Description                                        | Equivalent        |
| -------------- | -------------------------------------------------- | ----------------- |
| `sassWatch`    | SCSS with source comments (expanded)               | `sass:watch`      |
| `sassBuild`    | SCSS without source comments (expanded)            | `sass:build`      |
| `cssMin`       | Combine + minify CSS                               | `cssmin`          |
| `tailwind`     | PostCSS/Tailwind processing                        | `postcss`         |
| `jsConcat`     | Concatenate JS (v1 + v2 in parallel)               | `concat`          |
| `rollupBundle` | Rollup CheckoutKlarna module                       | `rollup`          |
| `terserDev`    | Minify JS (keep console/debugger)                  | `terser:dev`      |
| `terserDist`   | Minify JS (drop console/debugger)                  | `terser:dist`     |
| `build`        | Production: sass -> cssmin -> rollup -> terserDist | `grunt build`     |
| `build-dev`    | Development: sass -> cssmin -> rollup -> terserDev | `grunt build-dev` |
| `default`      | Watch mode (runs all tasks at start)               | `grunt` (default) |


## Files Changed

### 1. Create `gulpfile.mjs`

New file using ESM syntax with all task definitions. Key structure:

```javascript
import gulp from 'gulp';
import gulpSass from 'gulp-sass';
import * as dartSass from 'sass';
import cleanCSS from 'gulp-clean-css';
import postcss from 'gulp-postcss';
import tailwindcss from 'tailwindcss';
import concat from 'gulp-concat';
import terser from 'gulp-terser';
import { rollup } from 'rollup';
// ... plugin imports

const sass = gulpSass(dartSass);

// Source definitions (identical globs from gruntfile.js)
// Task functions
// Watch configuration
// Composed build tasks
```

The SCSS, CSS, JS concat, and Tailwind tasks use Gulp's streaming pipeline (`gulp.src().pipe().pipe(gulp.dest())`). The Rollup task uses Rollup's native async API directly (no gulp plugin needed).

Watch mode will use `gulp.watch()` with the same file patterns, and `{ ignoreInitial: false }` to replicate Grunt's `atBegin: true` behavior.

### 2. Update `package.json`

**Remove** (11 packages):

- `grunt`, `grunt-cli`, `grunt-contrib-concat`, `grunt-contrib-cssmin`
- `grunt-contrib-watch`, `grunt-env`, `grunt-postcss`
- `grunt-rollup`, `grunt-sass`, `grunt-terser`, `load-grunt-tasks`

**Add** (5 packages):

- `gulp` (^5.0.0)
- `gulp-sass` (^6.0.0)
- `gulp-clean-css` (latest)
- `gulp-postcss` (latest)
- `gulp-concat` (latest)
- `gulp-terser` (latest)

**Keep** (unchanged):

- `sass`, `postcss`, `tailwindcss`, `terser` (core tools still used)
- All `@babel/*`, `@rollup/*`, `@tailwindcss/*` packages
- `breakpoint-sass`, `breakpoint-slicer`, `compass-mixins-template`
- `autoprefixer`, `animate.css`, `tailwind-animatecss`

**Update scripts:**

```json
{
  "scripts": {
    "dev": "gulp",
    "build": "gulp build",
    "build-dev": "gulp build-dev"
  }
}
```

**Update engines** to `>= 16.0.0` (Gulp 5 requires Node 16+).

### 3. Delete `gruntfile.js`

Remove the old Grunt configuration after the Gulp setup is verified.

## Key Implementation Details

- **SCSS include paths**: Preserved exactly from the Gruntfile (`breakpoint-sass`, `breakpoint-slicer`, `compass-mixins-template`, and project-local paths)
- **JS source order**: The concatenation order for v1.0.0 and v2.0.0 bundles is preserved exactly (jQuery first, lodash second, libs, source, modules, angular, template.js last)
- **Glob exclusions**: Negative globs (`!./source/libs/@1jquery/latest/jquery.js`) preserved in concat sources
- **Rollup config**: Same Babel presets, plugins, IIFE format, and external/globals config
- **Terser options**: Both dev and dist modes preserved with identical `ecma`, `compress`, `mangle` settings
- **Tailwind config**: `tailwind.config.js` is untouched -- `gulp-postcss` reads it the same way `grunt-postcss` did

## Risk Considerations

- **Glob ordering**: Gulp uses `glob-stream` which may resolve glob ordering slightly differently than Grunt's `grunt.file.expand`. The JS concatenation order should be tested carefully to ensure jQuery/lodash load first.
- **Sourcemaps**: Gulp 5 has built-in sourcemap support via `{ sourcemaps: true }` in `gulp.src()` and `gulp.dest()`, which replaces `grunt-contrib-watch`'s sourceMap option.
- **File overwrite**: Terser tasks read and write to the same path (e.g., `assets/js/app.js`). This needs special handling in Gulp using `gulp.src` with `{ allowEmpty: true }` and writing to the same directory via `gulp.dest()`.

