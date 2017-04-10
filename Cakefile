use 'sake-bundle'
use 'sake-outdated'
use 'sake-publish'
use 'sake-version'

task 'clean', 'clean project', ->
  exec 'rm -rf lib'

task 'build', 'build project', ->
  Promise.all [
    bundle.write
      entry:  'src/cjs.coffee'
      dest:   'lib/es-is.js'
      format: 'cjs'
    bundle.write
      entry:  'src/index.coffee'
      dest:   'lib/es-is.mjs'
      format: 'es'
  ]

task 'test', 'test project', ['build'], ->
  require './test'
