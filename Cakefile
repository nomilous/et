which         = require 'which' 
{spawn, exec} = require 'child_process'
watchit       = require 'watchit'

build = (coffeeOpts) ->
    
    options = coffeeOpts
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr

watch = (dirs, callback) ->

    for dir in dirs

        watchit dir, {

            include: true
            recurse: true
            debounce: true

        }, callback


task 'build', 'Compile the cofee', ->

    build ['-c','-b', '-o', 'lib', 'src']


task 'dev', 'Continuous compile / test', ->

    watch ['src', 'spec'], (event, file) -> 

        return unless event == 'change'

        changed = file.match /(src|spec)\/(.{1,})(\.coffee)/
        specFile = changed[0]

        if changed[1] == 'src'

            console.log "COMPILE: #{changed[0]} (actually compiles all)"
            build ['-c', '-b', '-o', "lib", "src"]
            specFile = "spec/#{changed[2]}_spec.coffee"


        console.log "RUN: #{specFile}"
        test = spawn 'node_modules/jasmine-node/bin/jasmine-node', ['--coffee', specFile]
        test.stdout.pipe process.stdout
        test.stderr.pipe process.stderr
        