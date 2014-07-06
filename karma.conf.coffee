require 'coffee-errors'

module.exports = (config) ->
  config.set
    colors: yes
    frameworks: ['browserify', 'mocha', 'chai']
    browsers: ['PhantomJS']

    files: [
      'test/**/*.coffee'
      'src/**/*.coffee'
    ]

    preprocessors:
      '**/*.coffee': ['browserify']

    browserify:
      extensions: ['.coffee']
      transform: ['coffeeify']
      watch: true
      debug: true
