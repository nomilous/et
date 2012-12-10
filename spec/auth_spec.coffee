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


    it 'is disabled if no user model or validate() configured', ->

        et.al auth: {}
        et.auth.enabled.should.equal false
    

    it 'provides a default validate() provided a user model exists', -> 

        et.al 
            app: 
                use: -> "mock connect.use()"
                get: -> "mock connect.get()"
                configure: -> 
            models:
                users:
                    get: (id) -> 

        et.auth.validate( 'user', 'pass' ).should.equal false


    describe 'allows a custom validate()', -> 

        beforeEach -> 

            et.al
                app: 
                    use: -> "mock connect.use()"
                    get: -> "mock connect.get()"
                    configure: -> 
                auth:
                    validate: (username, password) -> 
                        if username == 'allowed'
                            return username: username
                        else
                            return false

    
        it 'that should return the authentic user', -> 

            user = et.auth.validate 'allowed', 'pass'
            user.should.eql { username: 'allowed' }


        it 'that should return false for inauthentic user', -> 

            user = et.auth.validate( 'notallowed', 'pass' )
            user.should.equal false


