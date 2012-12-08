jasmine = require 'jasmine-node'
Ebb     = require '../lib/Ebb'

describe "Ebb", ->

    beforeEach ->

        #
        # configuring returns the middleware callback
        # 

        @middleware = Ebb.configure
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


    it 'configures rest response model functionality', -> 

        @middleware @request, @response, @next
        expect( @responseData ).toEqual
            id: '12345'
            model: 'things'

    it 'does not call next() if request specifies known model', ->

        @middleware @request, @response, @next
        expect( @nextWasCalled ).toEqual false


    it 'calls next() if request specifies no known model', -> 

        request = 
            path: '/stuff/12345'


        @middleware request, @response, @next

        expect( @nextWasCalled ).toEqual true


