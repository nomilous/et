should  = require 'should' 
et      = require '../src/et'

describe "EtAuth", ->

    
    it 'can be disabled', (done) -> 

        et.al  
            port: 3000
            auth: false
        et.auth.enabled.should.equal false
        done()


    it 'is disbled if session is disabled', (done) -> 

        et.al 
            port: 3000
            session: false
        et.auth.enabled.should.equal false
        done()


    it 'is disabled if no user model or validate() configured', (done) -> 

        et.al 
            port: 3000
            auth: {}
        et.auth.enabled.should.equal false
        done()
    

    it 'provides a default validate() provided a user model exists', (done) -> 

        et.al 
            app: 
                use: -> "mock connect.use()"
                get: -> "mock connect.get()"
                configure: -> 
            models:
                users:
                    get: (id) -> 

        et.auth.validate( 'user', 'pass' ).should.equal false
        done()


    describe 'allows a custom validate()', -> 

        beforeEach (done) -> 

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

            done()

    
        it 'that should return the authentic user', (done) -> 

            user = et.auth.validate 'allowed', 'pass'
            user.should.eql { username: 'allowed' }
            done()


        it 'that should return false for inauthentic user', (done) -> 

            user = et.auth.validate( 'notallowed', 'pass' )
            user.should.equal false
            done()


    it 'provides a /login endpoint', (done) -> 

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
        done()


