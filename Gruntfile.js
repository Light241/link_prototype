'use strict';

module.exports = function (grunt) {

    grunt.initConfig({
            pkg: grunt.file.readJSON('./package.json'),
            coffeeSrc: ['./src/**/*.coffee'],
            jsProd: './prod/app.js',
            jshint: {
                options: {
                    globalstrict: true,
                    strict: false,
                    globals: {
                        console: true,
                        localStorage: true
                    }
                },
                src: '<%= jsProd %>'
            },
            watch: {
                coffee: {
                    files: '<%= coffeeSrc %>',
                    tasks: 'newer:coffee'
                }
            },
            coffee: {
                compile: {
                    files: {
                        '<%= jsProd %>': '<%= coffeeSrc %>'
                    }
                }
            }
        }
    );

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-newer');

    grunt.registerTask('check', ['jshint']);
}
;
