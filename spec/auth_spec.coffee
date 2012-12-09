jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtAuth", ->

    
    it 'can be disabled', ->

        et.al auth: false
        et.auth.enabled.should.equal false


    it 'is disbled if session is disabled', -> 

        et.al session: false
        et.auth.enabled.should.equal false

    
    it 'provides a default validator', -> 

        et.al()
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

    
        it 'that should return the authentic user', -> 

            user = et.auth.validator 'allowed', 'pass'
            user.should.eql { username: 'allowed' }


        it 'that should return false for inauthentic user', -> 

            user = et.auth.validator( 'notallowed', 'pass' )
            user.should.equal false

