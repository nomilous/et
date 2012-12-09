jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtAuth", ->

    
    xit 'can be disabled', ->

        et.al auth: false
        et.auth.enabled.should.equal false


    xit 'is disbled if session is disabled', -> 

        et.al session: false
        et.auth.enabled.should.equal false


    xit 'is disabled if no user model or validator configured', ->

        et.al auth: {}
        et.auth.enabled.should.equal false

    
    it 'provides a default validator provided a user model exists', -> 

        et.al 
            app: 
                use: -> "mock connect.use()"
                get: -> "mock connect.get()"
            models:
                users:
                    get: (id) -> 

        et.auth.validator( 'user', 'pass' ).should.equal false


    describe 'allows a custom validator', -> 

        beforeEach -> 

            et.al
                auth:
                    validator: (username, password) -> 
                        if username == 'allowed'
                            return username: username
                        else
                            return false

    
        xit 'that should return the authentic user', -> 

            user = et.auth.validator 'allowed', 'pass'
            user.should.eql { username: 'allowed' }


        xit 'that should return false for inauthentic user', -> 

            user = et.auth.validator( 'notallowed', 'pass' )
            user.should.equal false

