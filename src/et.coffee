et =

    session: require './session'
    model:   require './model'
    auth:    require './auth'
    route:   require './route'


    al: ( opts = {} ) -> 

        console.log 'init et.al()'

        et.session.config opts
        et.model.config opts
        et.auth.config opts
        et.route.config opts
        et.databases = opts.databases

        return ( req, res, next ) -> 

            #
            # attach et instance to inbound request
            # and pass onward into the stack
            #

            req._et = et

            next()
    
module.exports = et
