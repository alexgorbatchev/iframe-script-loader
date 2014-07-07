# iframe-script-loader

[![GitTip](http://img.shields.io/gittip/alexgorbatchev.svg)](https://www.gittip.com/alexgorbatchev/)
[![Dependency status](https://david-dm.org/alexgorbatchev/iframe-script-loader.svg)](https://david-dm.org/alexgorbatchev/iframe-script-loader)
[![devDependency Status](https://david-dm.org/alexgorbatchev/iframe-script-loader/dev-status.svg)](https://david-dm.org/alexgorbatchev/iframe-script-loader#info=devDependencies)
[![Build Status](https://secure.travis-ci.org/alexgorbatchev/iframe-script-loader.svg?branch=master)](https://travis-ci.org/alexgorbatchev/iframe-script-loader)

[![NPM](https://nodei.co/npm/iframe-script-loader.svg)](https://npmjs.org/package/iframe-script-loader)

A basic helper module to load scripts into an IFRAME. This is helpful if you are building a service that is meant to be executed on 3rd party sites and you want to avoid any possible conflicts.

## Installation

    npm install iframe-script-loader

## Usage

    var iframeScriptLoader = require('iframe-script-loader');

    var scripts = {
      async: '//cdnjs.cloudflare.com/ajax/libs/async/0.9.0/async.js',
      URI: 'http://cdnjs.cloudflare.com/ajax/libs/URI.js/1.11.2/URI.min.js'
    };

    iframeScriptLoader(scripts, function(err, results) {
      // results.async != null
      // results.URI != null
    });

## API

### iframeScriptLoader(scripts, callback)

- `scripts` is a key/value table where a key is a script name and at the same time variable name that loaded script adds to `window`, eg `window[key]`. The value is script source.
- `callback` is a `function(err, results)` that gets called when all scripts have loaded. `results` is a key/value table which contains the same keys as `scripts` and the values are loaded scripts.

## Testing

    npm test # runs test suite once
    npm run dev # starts karma in watch mode

# License

The MIT License (MIT)

Copyright (c) 2014 Alex Gorbatchev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
