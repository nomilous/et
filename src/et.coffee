et =

    session: require './session'
    rest:    require './rest'
    auth:    require './auth'

    al: ( opts = {} ) -> 

        console.log 'init et.al()'

        et.session.config opts
        et.rest.config opts
        et.auth.config opts

        return ( req, res, next ) -> 

            next()
    
module.exports = et
