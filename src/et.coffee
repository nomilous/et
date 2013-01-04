Restify = require 'restify'

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

        gotApp = opts.app != undefined

        unless opts.app or opts.port

            throw 'et.al() requires opts.app or opts.port'


        unless gotApp

            opts.app = Restify.createServer()

            #
            # TODO: Use useful configs on Restify.createServer()
            #       https://github.com/mcavage/node-restify
            #

            opts.app.listen opts.port


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

        if gotApp

            #
            # opts.app was defined
            # ie. Using an external 'connect' stack
            #

            return @last


        #
        # return the restify server
        #

        opts.app.use @first
        return opts.app


module.exports = new Et()  # singleton
