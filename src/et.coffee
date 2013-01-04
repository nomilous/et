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

        #
        # first middleware in the et stack
        #
        # attach et instance to inbound request
        # and pass onward into the stack
        #

        @first = ( req, res, next ) -> 



            req.et = et
            next()

        opts.app.use @first if opts.app


        @last = ( req, res, next ) -> 

            #
            # last middleware in the et stack
            #

            console.warn 'UNHANDLED request ', req.path 
            next()


        


        @session.config this, opts
        @model.config this, opts
        @auth.config this, opts
        @route.config this, opts


        if opts.app

            #
            # opts.app is defined
            # 
            # ie. Using an external 'connect' stack
            #

            return @last




        return null # pending internal restify connect stack


module.exports = new Et()  # singleton
