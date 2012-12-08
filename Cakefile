which = require 'which' 
{spawn, exec} = require 'child_process'

build = ->
    
    console.log "BUILDING"
    options = ['-c','-b', '-o', 'lib', 'src']
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr

task 'build', 'Compile the cofee', ->

    build()