# Modular Theme

A modular, fast theme for the Dandomain platform built with Tailwind CSS 4.1 and Gulp.

## Features

- **Tailwind CSS 4.1** - Modern utility-first CSS framework
- **Gulp 5** - Fast build system with ESM support
- **Modular Architecture** - Clean, maintainable code structure with modular components
- **Performance Optimized** - Fast builds and optimized output

## Getting Started

### Prerequisites

- Node.js >= 18.0.0
- npm or yarn

### Installation

```bash
npm install
```

### Development

Start the development server with watch mode:

```bash
npm run dev
```

This will:
- Watch for SCSS/CSS changes and compile with Tailwind
- Watch for JavaScript changes and concatenate/minify
- Generate source maps for debugging

### Building

Build for production:

```bash
npm run build
```

Build for development (with console logs):

```bash
npm run build-dev
```

## Project Structure

```
modular/
├── assets/          # Compiled assets (CSS, JS)
├── source/          # Source files
│   ├── css/         # Additional CSS files
│   ├── js/          # JavaScript source files
│   └── scss/        # SCSS source files (with Tailwind)
├── partials/        # Template partials
├── modules/         # Theme modules (to be added)
├── gulpfile.mjs     # Gulp build configuration
├── postcss.config.mjs # PostCSS configuration
└── package.json      # Dependencies and scripts
```

## Tailwind CSS

This theme uses Tailwind CSS 4.1 with the new CSS-first configuration approach. Tailwind is imported directly in `source/scss/template.scss`:

```scss
@import "tailwindcss";
```

Custom Tailwind configuration can be added directly in CSS using CSS variables and `@theme` directives.

## Vendor libs (node_modules)

Vendor JavaScript and CSS are pulled from **node_modules** (no `source/libs` folder). The build concatenates them into:

- **`assets/js/template.js`** – vendor JS (jQuery, Lodash, Fancybox, jsrender, cookieconsent, etc.) plus theme JS from `source/js/`
- **`assets/css/libs.css`** – vendor CSS (e.g. Fancybox, cookieconsent)

To add a library:

1. Install it: `npm install <package-name>`
2. In `gulpfile.mjs`, add the package’s main/dist path to the `vendorJs` or `vendorCss` arrays (order matters for JS: jQuery first, then plugins that depend on it).
3. Run `npm run build` or `npm run dev`.

jQuery is pinned to v3 for UMD/global build compatibility with the plugins.

## Build Process

The Gulp build process handles:

1. **Libs CSS** - Concatenates vendor CSS from node_modules to `libs.css`
2. **SCSS Compilation** - Compiles SCSS files with Dart Sass
3. **Tailwind Processing** - Processes Tailwind directives via PostCSS
4. **CSS Minification** - Minifies template.css and libs.css for production
5. **JavaScript Concatenation** - Combines vendor JS and theme JS
6. **JavaScript Minification** - Minifies JS for production

## Module Development

Modules will be redesigned one by one with Tailwind CSS. The source folder structure is ready for:

- Custom SCSS files in `source/scss/`
- Custom JavaScript files in `source/js/`
- Template files in `modules/` (to be added)

## Notes

- This is a foundational setup - modules will be added and redesigned incrementally
- The theme is based on `template007_1` but uses modern tooling
- All modules will be redesigned with Tailwind CSS utilities
