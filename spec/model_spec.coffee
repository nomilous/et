should  = require 'should' 
et      = require '../src/et'

describe "EtModel", ->

    beforeEach (done) ->

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

        done()


    xit 'configures rest response model functionality', (done) ->  

        @middleware @request, @response, @next
        @responseData.should.equal
            id: '12345'
            model: 'things'
        done()


    xit 'does not call next() if request specifies known model', (done) -> 

        @middleware @request, @response, @next
        @nextWasCalled.should.equal false
        done()


    it 'calls model.config with opts if defined', (done) -> 

        opts = 
            configureThings: 
                value: 1
            models: 
                things: 
                    config: (opts) -> 
                        opts.configureThings.value = 2

        et.model.config et, opts
            
        opts.configureThings.value.should.equal 2
        done()


    it 'calls next() if request specifies no known model', (done) -> 

        request = path: '/stuff/12345'
        @middleware request, @response, @next
        @nextWasCalled.should.equal true
        done()


    it 'loads models', (done) -> 

        et.model.loadModel {}, 'plural', get: (req, res) -> { data: '' }
        et.model.models.plural.get( '12345' ).should.eql { data: '' }
        done()


    it 'configures GET route if get(req, res) is defined', (done) -> 

        et.model.loadModel {}, 'plural', get: (req, res)  ->
        et.model.routes.get.plural.route.should.equal '/plural/:id' 
        done()


    describe 'does not load GET route if get()', -> 

        it 'does not have 2 args', (done) -> 

            et.model.loadModel {}, 'plural', get: () ->
            should.not.exist et.model.routes.get.plural
            done()

        it 'is undefined', (done) -> 

            et.model.loadModel {}, 'plural', wet: (id) ->
            should.not.exist et.model.routes.get.plural
            done()

