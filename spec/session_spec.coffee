jasmine = require 'jasmine-node'
should  = require 'should' 
et      = require '../lib/et'

describe "et.session", ->


    it "is enabled by default", -> 

        et.session.config {}
        et.session.enabled.should.equal true

    it 'can be disabled', ->

        et.session.config { session: false }
        et.session.enabled.should.equal false

    it 'uses a secret from config', -> 

        et.session.config session: secret: "Altes Tellenlied"
        et.session.secret.should.equal "Altes Tellenlied"

