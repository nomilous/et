jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "et.Session", ->


    it "enabln't unless opts defines session", -> 

        et.session.config {}
        et.session.enabled.should.equal false


    it 'is enabled if opts defines session', -> 

        et.session.config session: secret: "Altes Tellenlied"
        et.session.enabled.should.equal true


    it 'requires a secret', -> 

        et.session.config session: {}
        et.session.enabled.should.equal false

