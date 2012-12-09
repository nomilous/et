jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtRest", ->

    beforeEach ->

        #
        # Clear routes from previous tests
        #

        et.rest.routes = {}

        #
        # configuring returns the middleware callback
        # 

        @middleware = et.rest.config
            models:
                things:
                    get: (id) ->
                        id: id
                        model: 'things'

                    #
                    # things.get(id) exists
                    # therefore /things/12343 will call it
                    # 

        #
        # mock thing request
        # 

        @request = 
            path: '/things/12345'


        # 
        # mock response object
        # 

        @responseData = null
        @response = 
            send: (data) => 
                @responseData = data


        #
        # watch for calls to next()
        # 
        # TODO: find out how to properly 'expect' function calls
        # 

        @nextWasCalled = false
        @next = => 
            @nextWasCalled = true


        #
        # mock app object 
        #

        @routes = {}
        @app = get: (route, callback) => @routes[route] = 1


    xit 'configures rest response model functionality', -> 

        @middleware @request, @response, @next
        @responseData.should.equal
            id: '12345'
            model: 'things'


    xit 'does not call next() if request specifies known model', ->

        @middleware @request, @response, @next
        @nextWasCalled.should.equal false

    it 'declares routes to the app if passed to config', -> 

        et.rest.config 
            app: @app
            models:
                stuff:
                    get: (id) -> 

        @routes['/stuff/:id'].should.equal 1


    it 'calls next() if request specifies no known model', -> 

        request = path: '/stuff/12345'
        @middleware request, @response, @next
        @nextWasCalled.should.equal true


    it 'loads models', ->

        et.rest.loadModel 'plural', get: (id) -> { data: '' }
        et.rest.models.plural.get( '12345' ).should.eql { data: '' }


    it 'loads GET route if get(id) is defined', -> 

        et.rest.loadModel 'plural', get: (id) ->
        et.rest.routes.get.plural.route.should.equal '/plural/:id' 


    describe 'does not load GET route if get()', -> 

        it 'has no id arg', ->

            et.rest.loadModel 'plural', get: () ->
            should.not.exist et.rest.routes.get.plural

    it 'is undefined', -> 

        et.rest.loadModel 'plural', wet: (id) ->
        should.not.exist et.rest.routes.get.plural


    it 'works standalone with express', -> 

        express  = require( 'express' )()
        port = 3002
        url  = "http://localhost:#{port}/things/1234"
        server = express.listen port

        express.use et.rest.config
            app: express
            models:
                things:
                    get: (id) -> "DATA#{id}"

        require('http').get url, (res) ->
            res.on 'data', (data) -> 
                server.close()

                data.toString().should.equal "DATA1234"
                

