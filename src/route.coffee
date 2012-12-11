class EtRoute

    @declareRoutes : (et, opts) -> 

        for route of @routes.get

            console.log "assigning route GET #{@routes.get[route].route}"

            opts.app.get @routes.get[route].route, (req, res) => 

                if @routes.get[route].callback.length > 1

                    #
                    # callback_has(id, response)
                    # it sends the data
                    #

                    return @routes.get[route].callback req.params.id, res

                res.send @routes.get[route].callback req.params.id
    
    @config : (opts = {}) ->

        et = require 'et' unless et

        unless et.model.models

            #
            # models were not loaded
            #

            et.model.config opts

        @routes =  et.model.routes

        @declareRoutes et, opts if opts.app

        return (req, res, next) -> 

            next()


module.exports = EtRoute
