should = require 'should'
logger = require '../src/logger'

describe 'EtLogger', ->

    it 'provides log methods', (done) -> 

        et = {}
        
        logger.config et

        et.log.trace.should.be.an.instanceOf Function
        et.log.debug.should.be.an.instanceOf Function
        et.log.info.should.be.an.instanceOf Function
        et.log.warn.should.be.an.instanceOf Function
        et.log.error.should.be.an.instanceOf Function
        et.log.fatal.should.be.an.instanceOf Function
        done()
