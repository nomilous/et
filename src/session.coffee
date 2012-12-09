Connect      = require 'connect'
Redis        = require 'redis'
ConnectRedis = require('connect-redis')(Connect)

et = {} unless et

#
# Initializes a redis backed session if
#  
# opts = {
#    app: <some connect based app thing> 
#    session: { secret: 'secret' } 
# }
# 
# The session uses connect.cookieParser()
# and connect.session() directly and only 
# requires app: <thing> to access the 
# active middleware stack 
# 
# Assumes redis on localhost with default 
# port and no authentication. 
# 
# Does not ensure redis is present, session
# is simply null of not.
# 

# 
# TODO: make production ready
# 
#       - support redis connect parameters
#       - verify and log 'redis is responding'?
#       - support heroku redis-to-go
#   
# #
# # Heroku redistogo connection
# #
# if process.env.REDISTOGO_URL
#   rtg   = require('url').parse process.env.REDISTOGO_URL
#   redis = require('redis').createClient rtg.port, rtg.hostname
#   redis.auth rtg.auth.split('username:password')[1]
# else
#   redis = require("redis").createClient()
#

class EtSession

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

            console.log "init redis"

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

module.exports = EtSession
