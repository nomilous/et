should  = require 'should' 
et      = require '../lib/et'
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
            static:
                public: 
                    path: __dirname + '/public'

            #port: 3000

        done()

    after (done) -> 
        server.close()
        fs.existsSync.restore()
        done()

    it 'automatically serves static assets from specified paths', (done) ->

        request "http://localhost:3000/public/test.html", (error, response, body) ->

            body.should.equal 'test'
            testpath.should.match /\/et\/spec\/public/
            done()

