'use strict';

module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jshint: {
      files: ['src/js/**/*.js']
    },
    uglify: {
      app: {
        options: {
          compress: true,
          mangle: true,
          sourceMap: true
        },
        files: {
          'dist/js/L.DNC.min.js': ['dist/js/L.DNC.js']
        }
      }
    },
    sass: {
      dist: {
        options: {
          style: 'compressed'
        },
        files: {
          'dist/css/app.css': 'src/sass/site.scss'
        }
      }
    },
    watch: {
      html: {
        files: ['index.html'],
      },
      stylesheets: {
        files: ['src/sass/**/*.scss'],
        tasks: ['css'],
      },
      js: {
        files: ['src/js/**/*.js'],
        tasks: ['js'],
      },
      options: {
        livereload: true // Prevent auto-reload of browser by setting to false
      },
    },
    connect: {
      default: {
        options: {
          base: './',
          keepalive: true
        }
      },
      dev: {
        options: {
          base: './',
        }
      },
    },
    concat: {
        dist: {
          src: ['src/js/*.js', 'src/js/menu/Menu.js', 'src/js/**/*.js'],
          dest: 'dist/js/L.DNC.js'
        },
    },
    karma: {
      unit: {
          configFile: 'spec/karma.conf.js'
      }
    }
  });

  // Loading tasks.
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-karma');

  // Tasks.
  grunt.registerTask('test', ['karma']);
  grunt.registerTask('lint', ['jshint']);
  grunt.registerTask('js:dev', ['jshint', 'concat', 'uglify', 'test']);
  grunt.registerTask('js', ['concat', 'uglify']);
  grunt.registerTask('css', ['sass']);
  grunt.registerTask('build', ['js:dev', 'css']);
  grunt.registerTask('build:basic', ['js', 'css']);
  grunt.registerTask('serve', ['connect:dev', 'watch']);
  grunt.registerTask('default', ['build', 'serve']);
};
