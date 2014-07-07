!function(e){if("object"==typeof exports&&"undefined"!=typeof module)module.exports=e();else if("function"==typeof define&&define.amd)define([],e);else{var f;"undefined"!=typeof window?f=window:"undefined"!=typeof global?f=global:"undefined"!=typeof self&&(f=self),f.iframeScriptLoader=e()}}(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(_dereq_,module,exports){
(function (global){
!function(e){if("object"==typeof exports&&"undefined"!=typeof module)module.exports=e();else if("function"==typeof define&&define.amd)define([],e);else{var f;"undefined"!=typeof window?f=window:"undefined"!=typeof global?f=global:"undefined"!=typeof self&&(f=self),f.iframeScript=e()}}(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof _dereq_=="function"&&_dereq_;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof _dereq_=="function"&&_dereq_;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(_dereq_,module,exports){
var createIframe, injectFunc;

createIframe = function() {
  var iframe, style;
  iframe = document.createElement('IFRAME');
  style = iframe.style;
  style.width = style.height = '1px';
  style.left = style.top = '-10px';
  style.position = 'absolute';
  return document.body.appendChild(iframe);
};

injectFunc = function(iframe, fn, opts) {
  var contentWindow, iframeDoc, script;
  contentWindow = iframe.contentWindow;
  iframeDoc = contentWindow.document;
  script = iframeDoc.createElement('SCRIPT');
  script.innerHTML = "var fn = " + (fn.toString()) + ";";
  iframeDoc.body.appendChild(script);
  return contentWindow.fn(opts);
};

module.exports = function(fn, opts, callback) {
  var iframe;
  iframe = createIframe();
  return setTimeout(function() {
    return callback(null, injectFunc(iframe, fn, opts));
  });
};


},{}]},{},[1])
(1)
});
}).call(this,typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{}],2:[function(_dereq_,module,exports){
module.exports = function (tasks, cb) {
  var results, pending, keys
  if (Array.isArray(tasks)) {
    results = []
    pending = tasks.length
  } else {
    keys = Object.keys(tasks)
    results = {}
    pending = keys.length
  }

  function done (i, err, result) {
    results[i] = result
    if (--pending === 0 || err) {
      cb && cb(err, results)
      cb = null
    }
  }

  if (!pending) {
    // empty
    cb && cb(null, results)
    cb = null
  } else if (keys) {
    // object
    keys.forEach(function (key) {
      tasks[key](done.bind(undefined, key))
    })
  } else {
    // array
    tasks.forEach(function (task, i) {
      task(done.bind(undefined, i))
    })
  }
}

},{}],3:[function(_dereq_,module,exports){
"use strict"

module.exports = function load(doc, src, fn) {
  if (typeof doc === 'string') {
    fn = src
    src = doc
    doc = document
  }

  var script = doc.createElement('script')
  script.type = 'text/javascript'
  script.src = src
  if (fn) onLoad(script, fn)
  script.onLoad = function(fn) {
    return onLoad(script, fn)
  }
  doc.body.appendChild(script);
  return script
}

function onLoad(script, fn) {
  script.addEventListener('load', function() {
    fn(null, script)
  })
  script.addEventListener('error', function(err) {
    fn(new Error('Failed loading script: ' + script.src))
  })
  return script
}

},{}],4:[function(_dereq_,module,exports){
var iframeScript, parallel, scriptLoader,
  __slice = [].slice;

iframeScript = _dereq_('iframe-script');

parallel = _dereq_('run-parallel');

scriptLoader = _dereq_('scriptloader');

module.exports = function(scripts, callback) {
  var jobs, results;
  jobs = [];
  results = {};
  return iframeScript((function() {
    return {
      doc: document,
      win: window
    };
  }), {}, function(err, _arg) {
    var doc, item, win, _fn, _i, _len;
    doc = _arg.doc, win = _arg.win;
    _fn = function(item) {
      var keys, src, _j;
      keys = 2 <= item.length ? __slice.call(item, 0, _j = item.length - 1) : (_j = 0, []), src = item[_j++];
      return jobs.push(function(done) {
        return scriptLoader(doc, src, function(err) {
          var key, _k, _len1;
          for (_k = 0, _len1 = keys.length; _k < _len1; _k++) {
            key = keys[_k];
            results[key] = win[key];
          }
          return done(err);
        });
      });
    };
    for (_i = 0, _len = scripts.length; _i < _len; _i++) {
      item = scripts[_i];
      _fn(item);
    }
    return parallel(jobs, function(err) {
      return callback(err, results);
    });
  });
};


},{"iframe-script":1,"run-parallel":2,"scriptloader":3}]},{},[4])
(4)
});