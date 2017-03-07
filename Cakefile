require 'shortcake'

use 'cake-test'
use 'cake-publish'
use 'cake-version'

task 'clean', 'clean project', ->
  exec 'rm -rf dist'

task 'build', 'build project', ->
  handroll = require 'handroll'

  bundle = yield handroll.bundle
    entry: 'src/index.coffee'

  yield bundle.write format: 'cjs'
  yield bundle.write format: 'es'

task 'build:test', 'build tests', ->
  handroll = require 'handroll'

  bundle = yield handroll.bundle
    entry:     'test/index.js'
    external:  true
    sourceMap: false

  yield bundle.write
    format: 'cjs'
    dest:   'dist/test.js'

task 'test', 'test project', ['build', 'build:test'], ->
  require './dist/test'
