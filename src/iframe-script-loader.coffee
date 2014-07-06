# https://github.com/ariya/phantomjs/issues/10522
# phantomjs uses old JS core... still?
require 'es5-shim'

iframeScript = require 'iframe-script'
parallel = require 'run-parallel'
scriptLoader = require 'scriptloader'

module.exports = (scripts, callback) ->
  results = {}

  iframeScript (-> {doc: document, win: window}), {}, (err, {doc, win}) ->
    for name of scripts
      do (name, src = scripts[name]) ->
        results[name] = (done) ->
          scriptLoader doc, src, (err) ->
            done err, win[name]

    parallel results, callback
