iframeScript = require 'iframe-script'
parallel     = require 'run-parallel'
scriptLoader = require 'scriptloader'

module.exports = (scripts, callback) ->
  jobs = []
  results = {}

  iframeScript (-> {doc: document, win: window}), {}, (err, {doc, win}) ->
    for item in scripts
      do (item) ->
        [keys..., src] = item

        jobs.push (done) ->
          scriptLoader doc, src, (err) ->
            results[key] = win[key] for key in keys
            done err

    parallel jobs, (err) -> callback err, results
