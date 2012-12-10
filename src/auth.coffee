#
# Initialises authentication using http://passportjs.org/
# 
Connect       = require 'connect'
passport      = require 'passport'
LocalStrategy = require('passport-local').Strategy


class EtAuth

    @enableAuth : ( et, opts ) -> 

        console.log 'enabling auth'

        opts.auth or= {}

        unless opts.auth.validate

            #
            # default validate
            # 
            # to override:
            # opts: { auth: { validate: function( usr, pass ) }}
            #

            userModel = et.rest.models.users

            if userModel.validate not instanceof Function

                console.warn "WARNING: user.validate(user, pass) undefined"
                opts.auth.validate = (username, password) -> false

            else if userModel.validate.length < 2
        
                console.warn "WARNING: user.validate() takes insufficient arguments"
                opts.auth.validate = (username, password) -> false

            else

                if userModel.get instanceof Function

                    # 
                    #
                    # 
                    # REMINDER: defining user.get will expose /users/:id
                    #      
                    #           ...to all!
                    # 
                    #

                    console.warn "WARNING: user.get(id) without ROLES"

                opts.auth.validate = (username, password) -> 

                    userModel.validate username, password


        @validate = opts.auth.validate

        passport.use new LocalStrategy (username, password, done) -> 

            unless user = opts.auth.validate username, password

                return done null, false,

                    message: 'Invalid username or password.'

            done null, user



        #
        # Serialise user to (and fro) session
        #
        # TODO: this properly...
        # 
        # e.g. 
        # 
        #     - entire user object into session store?
        #     - or just id and get user from db
        #     - is the whole user necessary??
        #     - when does passport do this stuff?
        #     - probably just need roles serialized?
        #     - dunno, lets see...
        # 

        passport.serializeUser (user, done) -> 
    
            console.log 'Passport serializing', user, 'to session'
            done null, user.id


        passport.deserializeUser (id, done) -> 
    
            console.log 'Passport deserialize', id, 'from session'
            err = null
            done err, 
                id: id
                user: 'still considering this'

        
        opts.app.configure ->

            opts.app.use Connect.logger('dev')
            opts.app.use Connect.bodyParser()
            opts.app.use passport.initialize()
            opts.app.use passport.session()

            opts.app.post '/login',

                passport.authenticate('local'), (req, res) ->

                    res.send req.user
        

    @config : ( opts = {} ) ->

        @enabled = opts.auth != false

        if @enabled

            et = require 'et' unless et

            if et.session == undefined or not et.session.enabled

                console.log "auth requires session"
                @enabled = false


            if et.rest == undefined or not et.rest.models.users

                unless opts.auth and opts.auth.validate

                    console.log "auth requires user model or validate() override"
                    @enabled = false


            @enableAuth et, opts if @enabled and opts.app


        return (req, res, next) -> 

            next()

module.exports = EtAuth
