jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtModel", ->

    beforeEach ->

        #
        # Clear routes from previous tests
        #

        et.model.routes = {}

        #
        # configuring returns the middleware callback
        # 

        @middleware = et.model.config
            models:
                things:
                    get: (req, res) ->
                        id: req.params.id
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


    it 'calls next() if request specifies no known model', -> 

        request = path: '/stuff/12345'
        @middleware request, @response, @next
        @nextWasCalled.should.equal true


    it 'loads models', ->

        et.model.loadModel 'plural', get: (req, res) -> { data: '' }
        et.model.models.plural.get( '12345' ).should.eql { data: '' }


    it 'configures GET route if get(req, res) is defined', -> 

        et.model.loadModel 'plural', get: (req, res)  ->
        et.model.routes.get.plural.route.should.equal '/plural/:id' 


    describe 'does not load GET route if get()', -> 

        it 'does not have 2 args', ->

            et.model.loadModel 'plural', get: () ->
            should.not.exist et.model.routes.get.plural

        it 'is undefined', -> 

            et.model.loadModel 'plural', wet: (id) ->
            should.not.exist et.model.routes.get.plural

