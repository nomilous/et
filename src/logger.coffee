bunyan = require 'bunyan'

#
# suggest
# 
# npm install -g bunyan
# tail -f log_file | bunyan
#

module.exports = class EtLogger

    @config: (et, opts = {}) -> 

        opts.logger ||= {}
        opts.logger.serializers ||= {} 

        opts.logger.name  ||= opts.name || 'untitled'
        
        opts.logger.level ||= process.env.LOG_LEVEL || 'debug'

        opts.logger.serializers.req ||= (req) -> 

            #
            # default request serializer
            #
            # TODO: this ?may not play nice? with inbound express req
            #  

            return {

                #
                # suggested desirables per documentation
                # TODO: re-evaluate req serializer
                #

                method: req.method
                url: req.url
                headers: req.headers

            }


        et.log = bunyan.createLogger opts.logger

        return (req, res, next) -> 

            #
            # This returned function is inserted as the first
            # responder in the connect stack
            #
            # It serializes the req into the log
            # 

            et.log.debug req: req
            next()

