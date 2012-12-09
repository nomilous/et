jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtAuth", ->

    it 'is disabled unless session is defined', ->

        et.al auth: {}
        et.auth.enabled.should.equal false

    it 'is enabled if session', -> 

        et.al 
            session: secret: 's' 
            auth: {}

        et.auth.enabled.should.equal true
