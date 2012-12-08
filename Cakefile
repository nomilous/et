which = require 'which' 
{spawn, exec} = require 'child_process'

build = (coffeeOpts)->
    
    options = coffeeOpts
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr


task 'build', 'Compile the cofee', ->

    build ['-c','-b', '-o', 'lib', 'src']

task 'dev', 'Continuous compile', ->

    build ['-c', '-b', '-w', '-o', 'lib', 'src']

task 'test', 'Run tests', ->

    build ['-c','-b', '-o', 'lib', 'src']
    