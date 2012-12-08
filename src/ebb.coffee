class Ebb

    @loadModel : (plural, defn) -> 

        @models[plural] = defn

    @loadModels : (models) -> 

        for plural, defn of models

            @loadModel plural, defn
    
    @configure : (opts = {}) ->

        @models or= {}

        @loadModels opts.models if opts.models

        return (req, res, next) -> 

            next()

module.exports = Ebb
