which         = require 'which' 
{spawn, exec} = require 'child_process'
watchit       = require 'watchit'

build = (coffeeOpts, after) ->
    console.log "build"
    options = coffeeOpts
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr
    after()

watch = (dirs, callback) ->
    for dir in dirs
        watchit dir, {
            include: true
            recurse: true
            debounce: true
        }, callback

runSpec = (specFile) ->
    console.log "RUN: #{specFile}"
    test = spawn 'node_modules/jasmine-node/bin/jasmine-node', ['--coffee', specFile]
    test.stdout.pipe process.stdout
    test.stderr.pipe process.stderr



task 'build', 'Compile the cofee', ->
    build ['-c','-b', '-o', 'lib', 'src'], -> 

task 'dev', 'Continuous compile / test', ->
    watch ['src', 'spec'], (event, file) -> 
        return unless event == 'change'
        changed = file.match /(src|spec)\/(.{1,})(\.coffee)/
        specFile = changed[0]
        if changed[1] == 'src'
            return build ['-c', '-b', '-o', "lib", "src"], ->
                runSpec "spec/#{changed[2]}_spec.coffee"
        runSpec specFile

task 'test', 'Test all', ->
    build ['-c', '-b', '-o', "lib", "src"], ->
        test = spawn 'node_modules/jasmine-node/bin/jasmine-node', ['--coffee', 'spec/']
        test.stdout.pipe process.stdout
        test.stderr.pipe process.stderr
