{spawn, exec} = require 'child_process'

task 'test', 'Run the test suite', ->
  exec 'mocha --compilers coffee:coffee-script --colors', (error, output) ->
    throw error if error
    console.log output