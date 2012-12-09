jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "et.Session", ->


    it "enabln't unless opts defines session", -> 

        et.Session.config {}
        et.Session.enabled.should.equal false


    it 'is enabled if opts defines session', -> 

        et.Session.config session: secret: "Altes Tellenlied"
        et.Session.enabled.should.equal true


    it 'requires a secret', -> 

        et.Session.config session: {}
        et.Session.enabled.should.equal false

