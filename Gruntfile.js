'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    app: {
      gruntfile: {
        src: 'Gruntfile.js'
      },
      lib: {
        src: ['lib/{,*/}*.{ls,js}']
      },
      test: {
        src: ['test/{,*/}*.{ls,js}']
      },
    },
    watch: {
      lib: {
        files: '<%= app.lib.src %>',
        tasks: ['test']
      },
      test: {
        files: '<%= app.test.src %>',
        tasks: ['test']
      },
    },
    simplemocha: {
      options: {
        reporter: 'spec',
        useColors: false,
        globals: ['should', 'sinon'],
        ignoreLeaks: false,
        growl: true
      },
      all: {
        src: ['test/test_helper.js', 'test/**/*.ls']
      }
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-simple-mocha');

  grunt.registerTask('test', 'simplemocha');
};
