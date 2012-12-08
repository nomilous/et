class Ebb

    @loadModel : (plural, defn) -> 

        @models[plural] = defn

        if defn.get instanceof Function 

            if defn.get.length == 1

                #
                # model defines get(id)
                # 

                @routes.get[plural] = "/#{plural}/:id"
                console.info "assigned route /#{plural}/:id"

            else 

                console.error "model for #{plural} defines get() without id"

        else

             console.warn "model for #{plural} defines no get()"



    @loadModels : (models) -> 

        for plural, defn of models

            @loadModel plural, defn
    
    @configure : (opts = {}) ->

        @models or= {}
        @routes or= {}
        @routes.get or= {}

        @loadModels opts.models if opts.models

        return (req, res, next) -> 

            next()

module.exports = Ebb
