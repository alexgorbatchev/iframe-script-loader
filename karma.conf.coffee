require 'coffee-errors'

module.exports = (config) ->
  opts =
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

  configSauceLabs opts if process.env.SAUCE_USERNAME and process.env.SAUCE_ACCESS_KEY
  config.set opts

configSauceLabs = (opts) ->
  browser = (browserName, version, platform) ->
    customLaunchers[browserName + version + platform] = {base: 'SauceLabs', browserName, platform, version}

  customLaunchers = {}

  {BROWSER, VERSION, PLATFORM} = process.env
  browser BROWSER, VERSION, PLATFORM

  opts.sauceLabs = testName: 'iframe-script-loader'
  opts.customLaunchers = customLaunchers
  opts.reporters = ['saucelabs']
  opts.browsers = Object.keys customLaunchers
