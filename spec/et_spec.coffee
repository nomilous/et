jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe 'et.al all encompasses:', -> 

    it 'rests per provided models', -> 

        et.al 
            models:
                swords:
                    get: (id) -> 'Caladbolg'

        et.rest.routes.get.swords.route.should.equal = '/swords/:id'


    it 'sessions by default', -> 

        et.al {}
        et.session.enabled.should.equal true


    it 'auths by default', -> 

        et.al {} 
        et.auth.enabled.should.equal true

