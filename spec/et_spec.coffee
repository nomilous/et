jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe 'et.al all encompasses:', -> 

    it 'attaches et self onto inbound requests', ->

        #
        # for later use in the stack, eg models
        # using _et.db.dbName
        # 

        req = {}, res = {}

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

