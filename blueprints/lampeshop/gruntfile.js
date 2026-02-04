module.exports = grunt => {
    
    //
    // Use node-sass as scss compiler
    const sass = require("sass");

    //
    // Use babel to build modules
    const nodeResolve = require('@rollup/plugin-node-resolve').nodeResolve;
    const commonjs = require('@rollup/plugin-commonjs');
    const getBabelOutputPlugin = require('@rollup/plugin-babel').babel;


    //
    // Define sources
    const scss_source = {
        "source/css/template.structure.css": "source/scss/template.structure.scss",
        "modules/checkoutklarna/source/css/checkout.css": "modules/checkoutklarna/source/scss/structure.scss",
        "modules/checkoutklarna/source/css/theme.css": "modules/checkoutklarna/source/scss/theme.scss"
    };
    const js_source = {
        "1.0.0": [
            "./source/libs/@1jquery/1.11.0/jquery.js",
            "./source/libs/@2lodash/2.4.1-custom/lodash.js",
            "./source/libs/*/latest/**/*.js",
            // libs to avoid:
            "!./source/libs/@1jquery/latest/jquery.js",
            "!./source/libs/@2lodash/latest/lodash.custom.js",
            // --
            "./source/js/*.js",
            "./modules/**/assets/js/*.js",
            "./modules/widgets/**/assets/js/*.js",
            "./source/js/angularjs/libs/angular-1.4.3/*.js",
            "./source/js/angularjs/libs/*.js",
            "./source/js/angularjs/app/*.js",
            "./source/js/angularjs/modules/**/*.js",
            "./assets/js/template.js"
        ],
        "2.0.0": [
            "./source/libs/*/latest/**/*.js",
            "./source/js/*.js",
            "./modules/**/assets/js/*.js",
            "./modules/widgets/**/assets/js/*.js",
            "./source/js/angularjs/libs/latest/*.js",
            "./source/js/angularjs/libs/*.js",
            "./source/js/angularjs/app/*.js",
            "./source/js/angularjs/modules/**/*.js",
            "./assets/js/template.js"
        ]
    };
    const js_minification = {
        "assets/js/app.js": js_source['1.0.0'],
        "assets/js/2.0.0/app.js": js_source['2.0.0'],
        "modules/checkoutklarna/includes/js/checkout.min.js": "modules/checkoutklarna/includes/js/checkout.min.js"
    };

    //
    // Setup Grunt
    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        //
        // watch for changes
        watch: {
            options: {
                atBegin: true,
                sourceMap: true
            },
            sass: {
                files: [
                    "./source/scss/**/*.scss",
                    "./modules/**/assets/scss/*.scss",
                    "./modules/widgets/**/assets/scss/*.scss"
                ],
                tasks: ["sass:watch","cssmin"]
            },
            css: {
                files: ["./assets/css/modules.css"],
                tasks: ["cssmin"]
            },
            js: {
                files: [
                    "./source/**/*.js",
                    "./modules/**/assets/js/*.js",
                    "./modules/**/include/js/*.js",
                    "./assets/js/template.js",
                ],
                tasks: ["concat", "rollup"]
            },
            postcss: {
                files: [
                    "./*.tpl",
                    "./partials/*.tpl",
                    "./modules/**/*.tpl",
                    "./modules/**/partials/*.tpl",
                    "./modules/**/**/**/*.{js,css}",
                    "./modules/widgets/**/*.tpl",
                    "./modules/widgets/**/partials/*.tpl",
                    "./modules/widgets/**/**/**/*.{js,css}",
                    "./source/js/platform.js"
                ],
                tasks: ["postcss"]
            }
        },


        //
        // sass compilation with node-sass
        sass: {
            "options": {
                implementation: sass,
                sourceMap: false,
                includePaths: [
                    "./node_modules/breakpoint-sass/stylesheets/",
                    "./node_modules/breakpoint-slicer/stylesheets/",
                    "./node_modules/compass-mixins-template/lib/",
                    "./source/scss/",
                    "./modules/**/assets/scss/",
                    "./modules/widgets/**/assets/scss/"
                ]
            },
            "watch": {
                options: {
                    outputStyle: "expanded",
                    sourceComments: true
                },
                files: scss_source
            },
            "build": {
                options: {
                    outputStyle: "expanded",
                    sourceComments: false
                },
                files: scss_source
            }
        },


        //
        // css minification and concatination
        cssmin: {
            combine: {
				options: {
					keepSpecialComments: 0
				},
                files: {
                    "assets/css/libs.css": ["./source/libs/*/latest/**/*.css", "./source/js/angularjs/libs/*.css", "./modules/**/assets/css/*.css", "./modules/widgets/**/assets/css/*.css"],
                    "modules/checkoutklarna/includes/css/checkout.min.css": ["./modules/checkoutklarna/source/css/checkout.css"],
                    "modules/checkoutklarna/includes/css/checkout.theme.min.css": ["./modules/checkoutklarna/source/css/theme.css"]
                }
            }
        },

        //
        // postcss for tailwindcss
        postcss: {
            options: {
                map: true, // inline sourcemaps
                processors: [
                    require('tailwindcss')()
                ]
            },
            dist: {
                expand: true,
                cwd: 'assets/tailwindcss/',
                src: ['**/*.css'],
                dest: 'assets/css/',
                ext: '.css'
            }
        },


        //
        // js concatination
        concat: {
            jswatch_v1: {
                src: js_source['1.0.0'],
                dest: "assets/js/app.js"
            },
            jswatch_v2: {
                src: js_source['2.0.0'],
                dest: "assets/js/2.0.0/app.js"
            }
        },


        //
        // js minification
        terser: {
            dev: {
                options: {
                    ecma: 5,
                    compress: {
                        drop_console: false,
                        drop_debugger: false,
                        global_defs: { DEBUG: true }
                    },
                    mangle: false
                },
                files: js_minification
            },
            dist: {
                options: {
                    ecma: 5,
                    compress: {
                        drop_console: true,
                        drop_debugger: true,
                        global_defs: { DEBUG: false }
                    },
                    mangle: { reserved: ['$','require','export','window','platform'] }
                },
                files: js_minification
            }
        },

        //
        // build integration for modules using babel
        rollup: {
            options: {
                format: 'iife',
                input: 'modules/checkoutklarna/source/js/CheckoutKlarna/index.js',
                plugins: [
                    nodeResolve({ browser: true }),
                    commonjs(),
                    getBabelOutputPlugin({
                        presets: [["@babel/preset-env", { targets: "defaults", useBuiltIns: "entry", corejs: 3 }]],
                        babelHelpers: 'runtime',
                        sourceMap: false,
                        exclude: /node_modules/,
                        plugins: [
                            "@babel/plugin-transform-runtime",
                        ]
                    })
                ],
                external: ["jquery"],
                globals: {
                    $: 'jQuery'
                }
            },
            dist: {
                files: {
                    "modules/checkoutklarna/includes/js/checkout.min.js": "modules/checkoutklarna/source/js/CheckoutKlarna/index.js"
                }
            }
        }
    });

    //
    // Use grunt-tasks to load modules instead of
    require("load-grunt-tasks")( grunt, { scope: "devDependencies" });

    //
    // Custom build task
    grunt.registerTask('build', ["sass:build", "cssmin", "rollup", "terser:dist"]);
    grunt.registerTask('build-dev', ["sass:build", "cssmin", "rollup", "terser:dev"]);

    //
    // Custom watch task
    grunt.registerTask("default", ["watch"]);
};
