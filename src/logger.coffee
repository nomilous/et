bunyan = require 'bunyan'

module.exports = class EtLogger

    @config: (et, opts = {}) -> 

        unless opts.logger

            opts.logger = 

                #
                # TODO logger defaults...
                #

                name: 'LOGNAME'

        et.log = bunyan.createLogger opts.logger

        return (req, res, next) -> 

            #
            # TODO: log on passing connect req
            #

            next()
