jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe 'et.al all encompasses:', -> 

    it 'rests', -> 

        et.al 
            models:
                swords:
                    get: (id) -> 'Caladbolg'

        et.Rest.routes.get.swords.route.should.equal = '/swords/:id'


    it 'sessions', -> 

        et.al
            session:
                secret: 'Altes Tellenlied'

        et.Session.enabled.should.equal true

