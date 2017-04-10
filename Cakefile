use 'sake-bundle'
use 'sake-outdated'
use 'sake-publish'
use 'sake-version'

task 'clean', 'clean project', ->
  exec 'rm -rf lib'

task 'build', 'build project', ->
  Promise.all [
    exec 'coffee -bcm -o lib/ src/'
    bundle.write
      entry:  'src/cjs.coffee'
      dest:   'lib/es-is.js'
      format: 'cjs'
  ]

task 'test', 'test project', ['build'], ->
  require './test'
