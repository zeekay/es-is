require 'shortcake'

use 'cake-bundle'
use 'cake-outdated'
use 'cake-publish'
use 'cake-test'
use 'cake-version'

task 'clean', 'clean project', ->
  exec 'rm -rf dist'

task 'build', 'build project', ->
  Promise.all [
    bundle.write
      entry:  'src/index.coffee'
      dest:   'lib/es-is.mjs'
      format: 'es'
    bundle.write
      entry:  'src/is.coffee'
      dest:   'lib/es-is.js'
      format: 'cjs'
  ]

task 'test', 'test project', ['build'], ->
  require './test'
