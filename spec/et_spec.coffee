jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe 'et.al all encompasses:', -> 

    it 'rests', -> 

        et.al 
            models:
                things:
                    get: (id) -> 'data'

        et.Rest.routes.get.things.route.should.equal = '/things/:id'
