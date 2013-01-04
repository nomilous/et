should  = require 'should' 
et      = require '../src/et'

describe "EtRoute", ->

    xit 'declares routes if app is provided', (done) -> 

        express  = require( 'express' )()
        port = 3002
        server = express.listen port

        express.use et.al
            app: express
            models:
                things:
                    get: (req, res) -> 
                        id: req.params.id
                        static: 'thing'
                stuffs:
                    get: (req, res) -> 
                        stuff: req.params.id
                

        url = "http://localhost:#{port}/things/1234"

        require('http').get url, (res) ->

            res.on 'data', (data) -> 
            
                server.close()

                data.toString().should.equal '{"id":"1234","static":"thing"}'
                done()
