jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe 'et.al all encompasses:', -> 

    xit 'attaches et self onto inbound requests', ->

        #
        # was testing on final function in stack...
        # um, how to test on first one? 
        #

        #
        # for later use in the stack, eg models
        # using _et.db.dbName
        # 

        req = {}
        res = {}

        et.al() req, res , ->

        req._et.should.equal et


    it 'rests per provided models', -> 

        et.al 
            models:
                swords:
                    get: (req, res) -> 'Caladbolg'

        et.model.routes.get.swords.route.should.equal = '/swords/:id'


    it 'sessions by default', -> 

        et.al {}
        et.session.enabled.should.equal true


    it 'auths by default', ->

        #
        # only if either models.users.validate(user,pass)
        # or auth.validate exist
        # 

        et.al
            models:
                users:
                    validate: (username, password) -> false

        et.auth.enabled.should.equal true

    it 'attaches to et self a reference to databases list if present', -> 

        et.al
            databases: 
                dbname: 
                    thirdParty: 'schema based db access'
                    eg: 'https://github.com/1602/jugglingdb'

        et.databases.dbname.eg.should.equal 'https://github.com/1602/jugglingdb'