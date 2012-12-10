et =

    session: require './session'
    model:   require './model'
    auth:    require './auth'
    route:   require './route'


    al: ( opts = {} ) -> 

        console.log 'init et.al()'

        et.session.config opts
        et.model.config opts
        et.auth.config opts
        et.route.config opts

        return ( req, res, next ) -> 

            next()
    
module.exports = et
