should  = require 'should' 
et      = require '../lib/et'
request = require 'request'

describe "EtRoute", ->

    it 'declares routes', (done) -> 

        port = 3002
        server = et.al
            port: port
            models:
                things:
                    get: (req, res) -> 
                        res.send
                            id: req.params.id
                            static: 'thing'
                
        request "http://localhost:#{port}/things/1234", (error, response, body) ->

            body.should.equal '{"id":"1234","static":"thing"}'
            server.close()
            done()
