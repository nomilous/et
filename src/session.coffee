Connect      = require 'connect'
Redis        = require 'redis'
ConnectRedis = require('connect-redis')(Connect)

et = {} unless et

class et.Session

    @loadSession : (session) -> 

        unless session.secret
            console.error "session requires secret:'secret'"
            return

        console.log "enabling sessions"
        @secret = session.secret
        @enabled = true

    @config : ( opts = {} ) ->

        @enabled = false
        @store = {}
        @loadSession opts.session if opts.session

        if @enabled and opts.app

            #
            # init redis sessionstore if 
            # app was passed in on opts
            # 
            
            redis = Redis.createClient()

            #
            # TODO: make this more configurable
            #

            opts.app.use Connect.cookieParser()
            opts.app.use Connect.session
                secret: @secret
                store: new ConnectRedis 
                    client: redis
        
        return (req, res, next) -> 

            next()

module.exports = et.Session
