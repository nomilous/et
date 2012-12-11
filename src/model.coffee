class EtModel

    @loadModel : (plural, defn) -> 

        @models[plural] = defn

        if defn.get instanceof Function 

            unless defn.get.length == 2

                console.error "UNDEFINED for #{plural}.get(req, res)"
                return


            @routes.get[plural] = 

                route: "/#{plural}/:id"
                callback: defn.get
            

    @loadModels : (models) -> 

        for plural, defn of models

            @loadModel plural, defn

    
    @config : (opts = {}) ->

        @models or= {}
        @routes or= {}
        @routes.get or= {}

        @loadModels opts.models if opts.models
        #@declareRoutes opts.app if opts.app

        return (req, res, next) -> 

            next()

module.exports = EtModel
