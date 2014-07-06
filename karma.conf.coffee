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

  # browser 'safari', '5', 'OS X 10.6'
  # browser 'safari', '6', 'OS X 10.8'
  browser 'safari', '7', 'OS X 10.9'
  # browser 'chrome', '35', 'OS X 10.9'
  browser 'chrome', '34', 'OS X 10.9'
  # browser 'firefox', '30', 'OS X 10.9'
  browser 'firefox', '29', 'OS X 10.9'
  # browser 'internet explorer', '9', 'Windows 7'
  # browser 'internet explorer', '10', 'Windows 7'
  browser 'internet explorer', '11', 'Windows 7'

  opts.sauceLabs = testName: 'iframe-script-loader'
  opts.customLaunchers = customLaunchers
  opts.reporters = ['saucelabs']
  opts.browsers = Object.keys customLaunchers
