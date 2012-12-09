#
# Initialises authentication using http://passportjs.org/
# 

passport = require 'passport'
Strategy = require('passport-local').Strategy


class EtAuth

    @enableAuth : ( opts ) -> 

        console.log 'enabling auth'

        opts.auth or= {}

        unless opts.auth.validator

            #
            # default validator
            # 
            # to override:
            # opts: { auth: { validator: function( usr, pass ) }}
            #
        
            opts.auth.validator = (username, password) -> 

                #
                # authentic returns user object
                #

                false


        #
        # WARNING: may remove direct access to validator later
        #

        @validator = opts.auth.validator

        passport.use new Strategy (username, password, done) -> 

            user = opts.auth.validator username, password

            unless user = @validator username, password

                return done null, false

                    message: 'Invalid username or password.'

            done null, user


        

    @config : ( opts = {} ) ->

        @enabled = opts.auth != false

        if @enabled

            #
            # auth requires et.session
            #

            et = require 'et' unless et
            @enabled = et.session != undefined and et.session.enabled

            @enableAuth opts unless @enabled and opts.app

        return (req, res, next) -> 

            next()

module.exports = EtAuth
