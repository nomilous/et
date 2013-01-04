should  = require 'should' 
et      = require '../src/et'

describe "EtAuth", ->

    
    xit 'can be disabled', ->

        et.al auth: false
        et.auth.enabled.should.equal false


    xit 'is disbled if session is disabled', -> 

        et.al session: false
        et.auth.enabled.should.equal false


    xit 'is disabled if no user model or validate() configured', ->

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

        #et.auth.validate( 'user', 'pass' ).should.equal false


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

    
        xit 'that should return the authentic user', -> 

            user = et.auth.validate 'allowed', 'pass'
            user.should.eql { username: 'allowed' }


        xit 'that should return false for inauthentic user', -> 

            user = et.auth.validate( 'notallowed', 'pass' )
            user.should.equal false


    xit 'provides a /login endpoint', -> 

        express  = require( 'express' )()
        port     = 3003
        server   = express.listen port


        message = JSON.stringify

            username: 'Childebert the Adopted',
            password: 'secret'


        express.use et.al

            app: express
            models: 
                users:
                    get: (id) -> 
                    validate: (username, password) -> 
                        id: 1
                        username: username


        req = require('http').request 

            host: 'localhost'
            port: port
            path: '/login'
            headers: 'Content-Type': 'application/json'
            method: 'POST', (res) -> 
                res.on 'data', (chunk) ->
                    server.close()
                    chunk.toString().should.eql '{"id":1,"username":"Childebert the Adopted"}'


        req.on 'error', (e) -> 
            server.close()
            'this'.should.equal 'didnt happen'
        req.write message
        req.end()


