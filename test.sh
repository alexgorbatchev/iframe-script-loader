#!/bin/bash

test() {
 ./node_modules/karma/bin/karma start --single-run --no-auto-watch
}

if [ -n "$SAUCE_USERNAME" ] && [ -n "$SAUCE_ACCESS_KEY" ]; then
  BROWSER='safari'              VERSION='5'    PLATFORM='OS X 10.6'   test &&
  BROWSER='safari'              VERSION='6'    PLATFORM='OS X 10.8'   test &&
  BROWSER='safari'              VERSION='7'    PLATFORM='OS X 10.9'   test &&
  BROWSER='chrome'              VERSION='35'   PLATFORM='OS X 10.9'   test &&
  BROWSER='chrome'              VERSION='34'   PLATFORM='OS X 10.9'   test &&
  BROWSER='firefox'             VERSION='29'   PLATFORM='OS X 10.9'   test &&
  BROWSER='firefox'             VERSION='30'   PLATFORM='OS X 10.9'   test &&
  BROWSER='internet explorer'   VERSION='9'    PLATFORM='Windows 7'   test &&
  BROWSER='internet explorer'   VERSION='10'   PLATFORM='Windows 7'   test &&
  BROWSER='internet explorer'   VERSION='11'   PLATFORM='Windows 7'   test
else
  test
fi
