should  = require 'should' 
et      = require '../src/et'

describe "et.session", ->


    it "is enabled by default", -> 

        et.session.config null, {}
        et.session.enabled.should.equal true

    it 'can be disabled', ->

        et.session.config null, { session: false }
        et.session.enabled.should.equal false

    it 'uses a secret from config', -> 

        et.session.config null, session: secret: "Altes Tellenlied"
        et.session.secret.should.equal "Altes Tellenlied"

