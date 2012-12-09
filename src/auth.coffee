class EtAuth

    @config : ( opts = {} ) ->

        #
        # auth requires et.session
        #

        et = require 'et' unless et
        @enabled = et.session != undefined and et.session.enabled

        return (req, res, next) -> 

            next()


module.exports = EtAuth
