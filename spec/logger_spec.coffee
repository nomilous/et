should = require 'should'
logger = require '../lib/logger'

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

    it 'defaults the log name', (done) -> 

        et = {}
        logger.config et
        et.log.fields.name.should.equal 'untitled'
        done()

    describe 'defaults', -> 

        et = {}
        middleware = null
        log_message_json_str = null

        before (done) -> 

            #
            # logger.config returns middleware( request, response, next )
            #

            middleware = logger.config et, 
                name: 'NAME'
                logger: 
                    stream: 
                        #
                        # fake stream writer saves that which was writen
                        #
                        write: (data) ->
                            log_message_json_str = data
            
            done()



        it 'sets the log name from opts.name', (done) -> 

            et.log.fields.name.should.equal 'NAME'
            done()

        it 'defaults the loglevel to debug', (done) -> 

            et.log._level.should.equal 20  # <--- ._level may move...
            done()


        it 'logs requests with a default serializer and passes the request onward', (done) -> 

            fake_request = 

                method: 'METHOD'
                url: 'awesome:://// https://github.com/trentm/node-bunyan'
                headers: 'HEADERS'

            middleware fake_request, {}, -> 

                #
                # test inside the next() callback
                # 
                # (The Request Was Logged)
                #
                
                logged_message = JSON.parse log_message_json_str
                # console.log logged # NICE!!
                logged_message.req.url.should.match /trentm\/node-bunyan/
                done()

