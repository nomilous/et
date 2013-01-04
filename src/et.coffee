class Et

    constructor: -> 

        #
        # singleton (see module.exports below)
        # 

        @session = require './session'
        @model   = require './model'
        @auth    = require './auth'
        @route   = require './route'


    al: ( opts = {} ) ->

        console.log 'init et.al()'

        @resource = opts.resource

        et = this

        if opts.app

            opts.app.use ( req, res, next ) -> 

                #
                # first middleware in the stack
                #
                # attach et instance to inbound request
                # and pass onward into the stack
                #

                req.et = et

                next()

        @session.config this, opts
        @model.config this, opts
        @auth.config this, opts
        @route.config this, opts


        return ( req, res, next ) -> 

            #
            # final call, pass out to any
            # middleware call that may have
            # been registered after et 
            #

            console.warn 'UNHANDLED request ', req.path 

            next()


module.exports = new Et()  # singleton
