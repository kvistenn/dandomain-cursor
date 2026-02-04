const excludeFromDist = [
    '!Dockerfile',
    '!node_modules/**',
    '!Jenkinsfile',
    '!Gemfile.lock',
    '!yarn.lock',
    '!vendor/**',
    '!e2e/**',
    '!pipeline/**'
];

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
        "source/css/framework.print.css": "source/scss/framework.print.scss",
        "source/css/libs/ie/ie.css": "source/scss/libs/ie/ie.scss",
        "source/css/print.css": "source/scss/print.scss",
        "source/css/template.closed.css": "source/scss/template.closed.scss",
        "source/css/template.ie.css": "source/scss/template.ie.scss",
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
            "./source/js/angularjs/libs/angular-1.4.3/*.js",
            "./source/js/angularjs/libs/*.js",
            "./source/js/angularjs/app/*.js",
            "./source/js/angularjs/modules/**/*.js"
        ],
        "2.0.0": [
            "./source/libs/*/latest/**/*.js",
            "./source/js/*.js",
            "./modules/**/assets/js/*.js",
            "./source/js/angularjs/libs/latest/*.js",
            "./source/js/angularjs/libs/*.js",
            "./source/js/angularjs/app/*.js",
            "./source/js/angularjs/modules/**/*.js"
        ],
        "ie": [
            "./source/js/ie/*/latest/*.js"
        ]
    };
    const js_minification = {
        "assets/js/app.js": js_source['1.0.0'],
        "assets/js/2.0.0/app.js": js_source['2.0.0'],
        "assets/js/ie.js": js_source['ie'],
        "modules/checkoutklarna/includes/js/checkout.min.js": "modules/checkoutklarna/includes/js/checkout.min.js"
    };


    //
    // Setup Grunt
    grunt.initConfig({

        //
        // watch for changes
        watch: {
            options: {
                atBegin: true,
                sourceMap: true
            },
            sass: {
                files: ["./source/scss/**/*.{scss,sass}"],
                tasks: ["sass:watch", "cssmin"]
            },
            js: {
                files: [
                    "./source/**/*.js",
                    "./modules/**/assets/js/*.js",
                    "./modules/**/include/js/*.js"
                ],
                tasks: ["concat", "rollup"]
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
                    "./source/scss/"
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
                    "assets/css/ie.css": ["./source/css/libs/ie/ie.css", "./source/js/ie/*/latest/**/*.css"],
                    "assets/css/libs.css": ["./source/libs/*/latest/**/*.css", "!./source/libs/torqueui/latest/css/print.min.css", "./source/js/angularjs/libs/*.css"],
                    "assets/css/print.css": ["./source/libs/torqueui/latest/css/print.min.css", "./source/css/print.css"],
                    "assets/css/template.closed.css": ["./source/css/template.closed.css"],
                    "assets/css/template.css": ["./source/css/template.structure.css"],
                    "assets/css/template.ie.css": ["./source/css/template.ie.css"],
                    "modules/framework/print/layout/print.css": ["./source/css/framework.print.css"],
                    "modules/checkoutklarna/includes/css/checkout.min.css": ["./modules/checkoutklarna/source/css/checkout.css"],
                    "modules/checkoutklarna/includes/css/checkout.theme.min.css": ["./modules/checkoutklarna/source/css/theme.css"]
                }
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
            },
            jswatchIE: {
                src: js_source['ie'],
                dest: "assets/js/ie.js"
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
                        global_defs: {DEBUG: true}
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
                        global_defs: {DEBUG: false}
                    },
                    mangle: {reserved: ['$', 'require', 'export', 'window', 'platform']}
                },
                files: js_minification
            }
        },

        //
        // build integration for modules using babel
        rollup: {
            options: {
                format: 'iife',
                plugins: [
                    nodeResolve({browser: true}),
                    commonjs(),
                    getBabelOutputPlugin({
                        presets: [["@babel/preset-env", {targets: "defaults", useBuiltIns: "entry", corejs: 3}]],
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
        },

        //
        // clear dist folder
        clean: {
            release: ['dist']
        },

        //
        // copy files to dist folder
        copy: {
            dist: {
                expand: true,
                src: ['**'].concat(excludeFromDist),
                dest: 'dist/'
            }
        }
    });

    //
    // Register tasks
    grunt.registerTask("default", ["watch"]);
    grunt.registerTask('build', ["sass:build", "cssmin", "rollup", "terser:dist"]);
    grunt.registerTask('build-dev', ["sass:build", "cssmin", "rollup", "terser:dev"]);
    grunt.registerTask('dist', ["sass:build", "cssmin", "rollup", "terser:dist", "clean", "copy:dist"]);

    //
    // Use grunt-tasks to load modules instead of
    require("load-grunt-tasks")(grunt, {scope: "devDependencies"});
};
