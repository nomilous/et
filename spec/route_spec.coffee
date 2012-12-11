jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtRoute", ->

    it 'declares routes if app is provided', ->

        express  = require( 'express' )()
        port = 3002
        server = express.listen port

        express.use et.route.config
            app: express
            models:
                things:
                    get: (req, res) -> 
                        id: req.params.id
                        static: 'thing'

        url = "http://localhost:#{port}/things/1234"

        require('http').get url, (res) ->
            res.on 'data', (data) -> 
                server.close()

                data.toString().should.equal '{"id":"1234","static":"thing"}'
