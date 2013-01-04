should  = require 'should' 
et      = require '../src/et'
request = require 'request'

describe "EtRoute", ->

    it 'declares routes if app is provided', (done) -> 

        port = 3002
        server = et.al
            port: port
            models:
                things:
                    get: (req, res) -> 
                        res.send
                            id: req.params.id
                            static: 'thing'
                stuffs:
                    get: (req, res) -> 
                        res.send
                            stuff: req.params.id
                
        request "http://localhost:#{port}/things/1234", (error, response, body) ->

            body.should.equal '{"id":"1234","static":"thing"}'
            server.close()
            done()
