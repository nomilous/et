rest = require './rest'

module.exports =

    #
    # an all encompasser
    #

    al : ( opts = {} ) -> 

        console.log 'init et.al()'

        rest.config opts

        return ( req, res, next ) -> 

            next()


    Rest : rest

