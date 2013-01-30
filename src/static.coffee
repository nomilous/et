nstatic = require 'node-static'
fs      = require 'fs'

module.exports = class EtStatic

    @config : ( et, opts ) ->

        if opts.root and fs.existsSync opts.root + '/public'

            #
            # if directory present, will serve static content
            #

            server = new nstatic.Server opts.root + '/public'

            opts.app.get /\/.*/, (req, res, next) -> 

                server.serve req, res, next
