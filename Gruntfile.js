'use strict';

module.exports = function (grunt) {

    grunt.initConfig({
            pkg: grunt.file.readJSON('./package.json'),
            watch: {
                coffee: {
                    files: './src/coffee/**/*.coffee',
                    tasks: 'newer:coffee'
                }
            },
            coffeelint: {
                all: ['./src/coffee/**/*.coffee'],
                options: {
                    'indentation': {
                        'level': 'ignore'
                    }
                }
            },
            coffee: {
                options: {
                    bare: true,
                    sourceMap: true
                },
                compile: {
                    files: {
                        './src/app.js': './src/coffee/**/*.coffee'
                    }
                },
                glob_to_multiple: {
                    expand: true,
                    flatten: true,
                    cwd: './src/coffee/',
                    src: ['*.coffee'],
                    dest: './src/js/',
                    ext: '.js'
                }
            }
        }
    );

    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-newer');

    grunt.registerTask('check', ['coffeelint']);
}
;
