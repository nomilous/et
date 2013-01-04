should  = require 'should' 
et      = require '../src/et'

describe 'et.al', -> 

    it 'throws exception unless opts.app or opts.port is defined', (done) -> 

        try 
            et.al()

        catch error
            error.should.match /requires opts.app or opts.port/
            done()


    it 'attaches et self onto inbound requests', (done) ->

        req = {}
        res = {}

        et.al port: 3000

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

        et.al 
            port: 3000
            models:
                swords:
                    get: (req, res) -> 'Caladbolg'
                pens:
                    get: (req, res) -> 'Je plie, et ne romps pas.'

        et.model.routes.get.swords.route.should.equal '/swords/:id'
        et.model.models.swords.get().should.equal 'Caladbolg'

        et.model.routes.get.pens.route.should.equal '/pens/:id'
        et.model.models.pens.get().should.equal 'Je plie, et ne romps pas.'
        done()


    it 'sessions by default', (done) -> 

        et.al port: 3000
        et.session.enabled.should.equal true
        done()


    it 'auths by default', (done) -> 

        #
        # only if either models.users.validate(user,pass)
        # or auth.validate exist
        # 

        et.al
            port: 3000
            models:
                users:
                    validate: (username, password) -> false

        et.auth.enabled.should.equal true
        done()


    it 'attaches to et self a reference to resources list', (done) ->  

        et.al
            port: 3000
            resource: 
                dbname: 
                    thirdParty: 'schema based db access'
                    eg: 'https://github.com/1602/jugglingdb'

        et.resource.dbname.eg.should.equal 'https://github.com/1602/jugglingdb'
        done()
