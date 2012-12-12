et =

    session: require './session'
    model:   require './model'
    auth:    require './auth'
    route:   require './route'


    al: ( opts = {} ) -> 

        console.log 'init et.al()'

        et.resource = opts.resource

        if opts.app

            opts.app.use ( req, res, next ) -> 

                #
                # first middleware in the stack
                #
                # attach et instance to inbound request
                # and pass onward into the stack
                #

                req._et = et

                next()

        et.session.config opts
        et.model.config opts
        et.auth.config opts
        et.route.config opts

        return ( req, res, next ) -> 

            #
            # final call, pass out to any
            # middleware call that may have
            # been registered after et 
            #

            console.warn 'UNHANDLED request ', req.path 

            next()
    
module.exports = et
