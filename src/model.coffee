class EtModel

    @loadModel : (opts, plural, defn) -> 

        @models[plural] = defn

        if defn.config instanceof Function

            #
            # A call is made to Model.config(opts, plural)
            # at initialization
            # 
            # - usually it is necessary to configure a 
            #   database schema
            # 
            # - opts.databases.dbName could be one such schema
            #   

            defn.config opts, plural

        if defn.get instanceof Function 

            unless defn.get.length == 2

                console.error "UNDEFINED for #{plural}.get(req, res)"
                return

            #
            # Model.get(req, res) is defined
            # 
            # - this automates the creation of the route
            # 
            #   /modelPlural/:id 
            # 
            # - and model.get(req, res) becomes the route handler
            # 
            # - req._et.databases provides access to the schema
            #   as configured in model.config assuming the stack
            #   was initialized via et.al as follows:
            # 
            #   et.al 
            #     databases: 
            #       databaseWithThings = new SchemaThing
            #     models:
            #       things: 
            #         config: (opts)
            # 

            @routes.get[plural] = 

                route: "/#{plural}/:id"
                callback: defn.get


    @loadModels : (opts, models) -> 

        for plural, defn of models

            @loadModel opts, plural, defn

    
    @config : (et, opts = {}) ->

        @models or= {}
        @routes or= {}
        @routes.get or= {}

        @loadModels opts, opts.models if opts.models

        return (req, res, next) -> 

            next()

module.exports = EtModel
