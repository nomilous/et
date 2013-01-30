should  = require 'should' 
et      = require '../src/et'
request = require 'request'

describe 'et.al', -> 

    server = null

    before (done) ->

        server = et.al
            port: 3000
            resource: 
                dbname: 
                    thirdParty: 'schema based db access'
                    eg: 'https://github.com/1602/jugglingdb'
            models:
                mountains:
                    get: (req, res) -> 
                        res.send 'Harā Bərəzaitī'
                swords:
                    get: (req, res) -> 'Caladbolg'
                pens:
                    get: (req, res) -> 'Je plie, et ne romps pas.'

        done()

    after (done) -> 

        server.close()
        done()


    it 'starts a restify server if app is undefined', (done) -> 

        request 'http://0.0.0.0:3000/mountains/1', (error, response, body) ->
        
            response.body.should.equal '"Harā Bərəzaitī"'
            done()


    it 'attaches et self onto inbound requests', (done) ->

        req = {}
        res = {}

        # server = et.al 
        #     port: 3000

        #
        # call first middleware
        #

        et.first req, res , ->

        #
        # did it attach reference to et?
        #

        req.et.should.equal et
        done()


    it 'rests per provided models', (done) -> 

        et.model.routes.get.swords.route.should.equal '/swords/:id'
        et.model.models.swords.get().should.equal 'Caladbolg'

        et.model.routes.get.pens.route.should.equal '/pens/:id'
        et.model.models.pens.get().should.equal 'Je plie, et ne romps pas.'
        done()


    it 'sessions by default', (done) -> 

        et.session.enabled.should.equal true
        done()


    # 
    xit 'auths by default', (done) -> 

        #
        # only if either models.users.validate(user,pass)
        # or auth.validate exist
        # 

        et.auth.enabled.should.equal true
        done()


    xit 'attaches to et self a reference to resources list', (done) ->  

        et.resource.dbname.eg.should.equal 'https://github.com/1602/jugglingdb'
        done()
