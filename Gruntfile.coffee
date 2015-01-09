module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    coffeelint:
      app:
        src: grunt.file.expand ['**/*.coffee', '!node_modules/**/*']
        options:
          arrow_spacing:
            level: 'error'
          colon_assignment_spacing:
            level: 'error'
            spacing:
              left: 0
              right: 1
          empty_constructor_needs_parens:
            level: 'error'
          line_endings:
            level: 'error'
          max_line_length:
            level: 'ignore'
          newlines_after_classes:
            level: 'error'
          no_empty_functions:
            level: 'error'
          no_empty_param_list:
            level: 'error'
          no_unnecessary_double_quotes:
            level: 'error'
          no_unnecessary_fat_arrows:
            level: 'error'
          non_empty_constructor_needs_parens:
            level: 'error'
          space_operators:
            level: 'error'
          spacing_after_comma:
            level: 'error'
    mochaTest:
      app:
        src: [
          'test/**/*.coffee'
        ]
        options:
          reporter: 'nyan'
          require: 'coffee-script/register'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.registerTask 'default', ['coffeelint', 'mochaTest']
