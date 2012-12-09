rest    = require './rest'
session = require './session' 

module.exports =

    #
    # an all encompasser
    #

    al : ( opts = {} ) -> 

        console.log 'init et.al()'

        session.config opts
        rest.config opts

        return ( req, res, next ) -> 

            next()


    #
    # standalones
    # 
 
    Rest    : rest
    Session : session
