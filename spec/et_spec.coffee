jasmine = require 'jasmine-node'
should  = require 'should' 
Et      = require '../lib/et'

describe 'Et.Rest', -> 

    it 'works standalone with express', -> 

        app      = require( 'express' )()
        port     = 3332
        url      = "http://localhost:#{port}/things/1234"
        server   = app.listen port

        app.use Et.Rest.config
            app: app
            models:
                things:
                    get: (id) -> "DATA#{id}"

        require('http').get url, (res) ->
            res.on 'data', (data) -> 
                server.close()

                data.toString().should.equal "DATA1234"
                
