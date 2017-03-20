require 'shortcake'

use 'cake-bundle'
use 'cake-outdated'
use 'cake-publish'
use 'cake-test'
use 'cake-version'

task 'clean', 'clean project', ->
  exec 'rm -rf dist'

task 'build', 'build project', ->
  bundle.write
    entry: 'src/index.coffee'

task 'build:test', 'build tests', ->
  Promise.all [
    bundle.write
      entry: 'src/index.coffee'

    bundle.write
      entry:     'test/index.js'
      dest:      'dist/test.js'
      external:  true
      sourceMap: false
      format:    'cjs'
  ]

task 'test', 'test project', ['build', 'build:test'], ->
  require './dist/test'
