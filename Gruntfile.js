'use strict';

module.exports = function (grunt) {

    grunt.initConfig({
            pkg: grunt.file.readJSON('./package.json'),
            jsSrc: ['./src/js/**/*.js'],
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
                src: '<%= jsSrc %>'
            },
            watch: {
                js: {
                    files: '<%= jsSrc %>',
                    tasks: 'newer:concat:js'
                }
            },
            concat: {
                js: {
                    src: ['<%= jsSrc %>'],
                    dest: '<%= jsProd %>'
                }
            }
        }
    );

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-newer');

    grunt.registerTask('check', ['jshint']);
}
;
