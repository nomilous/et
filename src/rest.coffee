Ebb = {} unless Ebb

class Ebb.Rest

    @loadModel : (plural, defn) -> 

        @models[plural] = defn

        if defn.get instanceof Function 

            if defn.get.length == 1

                #
                # model defines get(id)
                # 

                @routes.get[plural] = "/#{plural}/:id"

            else 

                console.error "model for #{plural} defines get() without id"

        else

             console.warn "model for #{plural} defines no get()"



    @loadModels : (models) -> 

        for plural, defn of models

            @loadModel plural, defn

    @declareRoutes : (app) -> 

        for route of @routes.get

            console.log "assigning route GET #{@routes.get[route]}"

            app.get @routes.get[route], -> 


    
    @config : (opts = {}) ->

        @models or= {}
        @routes or= {}
        @routes.get or= {}

        @loadModels opts.models if opts.models
        @declareRoutes opts.app if opts.app

        return (req, res, next) -> 

            next()

module.exports = Ebb.Rest
