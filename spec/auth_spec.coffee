jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "EtAuth", ->

    
    it 'can be disabled', ->

        et.al auth: false
        et.auth.enabled.should.equal false


    it 'is disbled if session is disabled', -> 

        et.al session: false
        et.auth.enabled.should.equal false
