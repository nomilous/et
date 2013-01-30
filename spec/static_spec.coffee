should  = require 'should' 
et      = require '../src/et'
request = require 'request'
sinon   = require 'sinon'
fs      = require 'fs'

describe "EtStatic", ->

    server = null
    testpath = null
    
    before (done) -> 
        sinon.stub fs, 'existsSync', (arg) -> 
            testpath = arg
            return true

        server = et.al 
            root: __dirname
            port: 3000

        done()

    after (done) -> 
        server.close()
        fs.existsSync.restore()
        done()

    it 'automatically serves static assets from /public if present', (done) ->

        request "http://localhost:3000/test.html", (error, response, body) ->

            body.should.equal 'test'
            testpath.should.match /\/et\/spec\/public/
            done()
