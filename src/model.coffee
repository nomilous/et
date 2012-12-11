class EtModel

    @loadModel : (opts, plural, defn) -> 

        @models[plural] = defn

        if defn.config instanceof Function

            defn.config opts, plural

        if defn.get instanceof Function 

            unless defn.get.length == 2

                console.error "UNDEFINED for #{plural}.get(req, res)"
                return


            @routes.get[plural] = 

                route: "/#{plural}/:id"
                callback: defn.get


    @loadModels : (opts, models) -> 

        for plural, defn of models

            @loadModel opts, plural, defn

    
    @config : (opts = {}) ->

        @models or= {}
        @routes or= {}
        @routes.get or= {}

        @loadModels opts, opts.models if opts.models

        return (req, res, next) -> 

            next()

module.exports = EtModel
