class EtAuth

    @config : ( opts = {} ) ->

        @enabled = opts.auth != false

        if @enabled

            #
            # auth requires et.session
            #

            et = require 'et' unless et
            @enabled = et.session != undefined and et.session.enabled

        return (req, res, next) -> 

            next()

module.exports = EtAuth
