class EtRoute

    @declareRoutes : (et, opts) -> 

        routes = et.model.routes

        for route of routes.get

            path     = routes.get[route].route
            callback = routes.get[route].callback

            if callback.length != 2

                console.error "ROUTE #{path} requires #{route}.get(req, res)"
                continue

            console.log "assigning route GET #{path}"
            opts.app.get path, callback

    
    @config : (et, opts = {}) ->

        unless et.model.models

            #
            # models were not loaded
            #

            et.model.config opts

        @declareRoutes et, opts if opts.app

        return (req, res, next) -> 

            next()


module.exports = EtRoute
