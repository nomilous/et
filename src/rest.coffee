Et = {} unless Et

class Et.Rest

    @loadModel : (plural, defn) -> 

        @models[plural] = defn

        if defn.get instanceof Function 

            if defn.get.length == 1

                @routes.get[plural] = 

                    #
                    # because model defines get(id)
                    #

                    route: "/#{plural}/:id"
                    callback: defn.get

            else 

                console.error "model for #{plural} defines get() without id"

        else

             console.warn "model for #{plural} defines no get()"


    @loadModels : (models) -> 

        for plural, defn of models

            @loadModel plural, defn


    @declareRoutes : (app) -> 

        for route of @routes.get

            console.log "assigning route GET #{@routes.get[route].route}"

            app.get @routes.get[route].route, (req, res) => 

                res.send @routes.get[route].callback req.params.id

    
    @config : (opts = {}) ->

        @models or= {}
        @routes or= {}
        @routes.get or= {}

        @loadModels opts.models if opts.models
        @declareRoutes opts.app if opts.app

        return (req, res, next) -> 

            next()

module.exports = Et.Rest
