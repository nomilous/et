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
                # default authenticator reqires user model
                # 

                false


        #
        # WARNING: may remove direct access to validator later
        #

        @validator = opts.auth.validator

        passport.use new Strategy (username, password, done) -> 

            unless user = @validator username, password

                return done null, false

                    message: 'Invalid username or password.'

            done null, user


        

    @config : ( opts = {} ) ->

        @enabled = opts.auth != false
        
        if @enabled

            et = require 'et' unless et

            if et.session == undefined or not et.session.enabled

                console.log "auth requires session"
                @enabled = false


            if et.rest == undefined or not et.rest.models.users

                unless opts.auth and opts.auth.validator

                    console.log "auth requires user model or validator override"
                    @enabled = false


            @enableAuth opts if @enabled and opts.app


        return (req, res, next) -> 

            next()

module.exports = EtAuth
