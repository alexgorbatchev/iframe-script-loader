# https://github.com/ariya/phantomjs/issues/10522
# phantomjs uses old JS core... still?
require 'es5-shim'
require 'coffee-errors'

{expect} = require 'chai'
iframeScriptLoader = require '../src/iframe-script-loader'

describe 'iframe-script-loader', ->
  @timeout 10000

  scripts = null

  before (done) ->
    expect(window.async).to.be.falsy
    expect(window.URI).to.be.falsy

    iframeScriptLoader [
      ['async', '//cdnjs.cloudflare.com/ajax/libs/async/0.9.0/async.js']
      ['URI', 'http://cdnjs.cloudflare.com/ajax/libs/URI.js/1.11.2/URI.min.js']
    ] , (err, results) ->
        scripts = results
        done()

  it 'does not load scripts into current window', ->
    expect(window.async).to.be.falsy
    expect(window.URI).to.be.falsy

  it 'loads scripts into a "variable"', ->
    expect(scripts.async).to.be.ok
    expect(scripts.URI).to.be.ok
