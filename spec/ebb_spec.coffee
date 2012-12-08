jasmine = require 'jasmine-node'
should  = require 'should' 
Ebb     = require '../lib/Ebb'

describe 'Ebb.Rest', -> 

    it 'works with express', -> 

        express  = require 'express'
        app      = express()
        port     = 3332
        url      = "http://localhost:#{port}/things/1234"
        response = null

        app.use Ebb.Rest.config
            app: app
            models:
                things:
                    get: (id) -> 
                        "DATA"

        server = app.listen port

        require('http').get url, (res) ->

            res.on 'data', (data) -> 

                response = data.toString()
                response.should.equal "DATA"
                server.close()
