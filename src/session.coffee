et = {} unless et

class et.Session

    @loadSession : (session) -> 

        unless session.secret
            console.error "session requires secret:'secret'"
            return

        @secret = session.secret
        @enabled = true

    @config : ( opts = {} ) ->

        @enabled = false
        @loadSession opts.session if opts.session

        return (req, res, next) -> 

            next()

module.exports = et.Session
