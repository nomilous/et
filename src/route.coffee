class EtRoute

    @declareRoutes : (et, opts) -> 

        for route of @routes.get

            console.log "assigning route GET #{@routes.get[route].route}"

            opts.app.get @routes.get[route].route, (req, res) => 

                unless @routes.get[route].callback.length == 2

                    error = "ROUTE #{route} requires #{route}.get(req, res)"

                    console.error error

                    return res.send 500

                @routes.get[route].callback req, res
                
    
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
