use 'sake-bundle'
use 'sake-outdated'
use 'sake-publish'
use 'sake-version'

task 'clean', 'clean project', ->
  exec '''
    rm -rf *.js
    rm -rf *.mjs
    rm -rf *.map
  '''

task 'build', 'build project', ->
  yield exec 'coffee -bcm -o ./ src/'
  yield exec 'mv index.js index.mjs'
  yield bundle.write
    entry:  'src/cjs.coffee'
    dest:   'index.js'
    format: 'cjs'
  yield exec 'rm cjs.js'

task 'test', 'test project', ['build'], ->
  require './test'
