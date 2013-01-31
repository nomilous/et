should  = require 'should' 
et      = require '../lib/et'

describe "et.session", ->

    it 'IS BROKEN WHEN REDIS IS RUNNING', (done) -> 

        #
        # which is obviously a problem...
        #
        true.should.equal false
        done()

    it "is enabled by default", (done) -> 

        et.session.config null, {}
        et.session.enabled.should.equal true
        done()

    it 'can be disabled', (done) -> 

        et.session.config null, { session: false }
        et.session.enabled.should.equal false
        done()

    it 'uses a secret from config', (done) -> 

        et.session.config null, session: secret: "Altes Tellenlied"
        et.session.secret.should.equal "Altes Tellenlied"
        done()
