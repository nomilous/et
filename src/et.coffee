Restify = require 'restify'

class Et

    constructor: -> 

        #
        # singleton (see module.exports below)
        # 

        @logger  = require './logger'
        @session = require './session'
        @model   = require './model'
        @auth    = require './auth'
        @static  = require './static'
        @route   = require './route'


    al: ( opts = {} ) ->

        console.log 'init et.al()'

        @resource = opts.resource

        et = this

        gotApp = opts.app != undefined

        opts.name ||= process.env.APP_NAME || 'untitled'
        opts.version ||= process.env.APP_VERSION || '0.0.0'
        opts.port ||= process.env.APP_PORT || 3000

        unless gotApp

            opts.app = Restify.createServer

                name: opts.name
                version: opts.version

            #
            # TODO: Use useful configs on Restify.createServer()
            #       https://github.com/mcavage/node-restify
            #

            opts.app.listen opts.port, ->

                #
                # TODO: fix server ocassionally already closed()... (in specs)
                #       by the time opts.app.url attempts to get address.
                # 
                #       how to know if running test or live?
                # 

                console.log 'restify listening at %s', opts.app.url

        #
        # logger as first middleware
        #

        opts.app.use @logger.config this, opts


        #
        # first middleware in the et stack
        #
        # attach et instance to inbound request
        # and pass onward into the stack
        #

        @first = ( req, res, next ) -> 

            req.et = et
            next()

        opts.app.use @first




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
        @static.config this, opts

        if gotApp

            #
            # opts.app was defined
            # ie. Using an external 'connect' stack
            #

            return @last


        #
        # return the restify server
        #

        #opts.app.use @first

        et.log.debug opts: opts

        return opts.app


module.exports = new Et()  # singleton
