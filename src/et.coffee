et =

    session: require './session'
    auth:    require './auth'
    rest:    require './rest'

    al: ( opts = {} ) -> 

        console.log 'init et.al()'

        et.session.config opts
        et.auth.config opts
        et.rest.config opts

        return ( req, res, next ) -> 

            next()
    
module.exports = et
