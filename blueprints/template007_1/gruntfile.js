const fs = require('fs');

const excludeFromDist = [
    '!Dockerfile',
    '!node_modules/**',
    '!Jenkinsfile',
    '!Gemfile.lock',
    '!yarn.lock',
    '!vendor/**',
    '!package-lock.json'
];

module.exports = grunt => {

    //
    // Use dart-sass as scss compiler
    const sass = require("sass");


    //
    // Define sources
    const scss_source = {
        "assets/css/template.css": "source/scss/template.scss",
        "modules/checkoutklarna/source/css/theme.css": "modules/checkoutklarna/source/scss/theme.scss"
    };


    //
    // Setup Grunt
    grunt.initConfig({


        //
        // watch for changes
        watch: {
            options: {
                atBegin: true
            },
            sass: {
                files: './source/scss/**/*.{scss,sass}',
                tasks: ['sass:watch']
            },
            js: {
                files: './source/**/*.js',
                tasks: 'uglify:watch'
            }
        },


        //
        // sass compilation with sass
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
                    "assets/css/template.css": "assets/css/template.css",
                    "modules/checkoutklarna/includes/css/checkout.theme.min.css": ["./modules/checkoutklarna/source/css/theme.css"]
                }
            }
        },

        //
        // js minification
        uglify: {
            watch: {
                files: {
                    'assets/js/template.js': ['./source/libs/**/*.js', './source/js/**/*.js']
                },
                options: {
                    compress: false,
                    mangle: false,
                    beautify: true
                }
            },
            build: {
                files: {
                    'assets/js/template.js': ['./source/libs/**/*.js', './source/js/**/*.js']
                },
                options: {
                    sourceMap: true,
                    preserveComments: false,
                    mangle: true,
                    compress: {
                        drop_console: true
                    }
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


    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-copy');

    //
    // Register tasks
    grunt.registerTask('default', ['watch']);
    grunt.registerTask('libs', ['uglify:build']);
    grunt.registerTask('build', ['sass:build', 'cssmin', 'libs']);
    grunt.registerTask('dist', ['sass:build', 'cssmin', 'libs', 'clean', 'copy:dist']);


    //
    // Use grunt-tasks to load modules
    require("load-grunt-tasks")(grunt, {scope: "devDependencies"});
};
