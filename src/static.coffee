nstatic = require 'node-static'
fs      = require 'fs'

module.exports = class EtStatic

    @config : ( et, opts ) ->

        if opts.static 

            servers = {}

            for key of opts.static

                path = opts.static[key].path

                if fs.existsSync path

                    et.log.debug 'stattic assign %s', path

                    #
                    # if directory present, will serve static content
                    #

                    servers[key] = new nstatic.Server path

                    re = new RegExp "^/#{ key }/"

                    opts.app.get re, (req, res, next) -> 

                        req.url = req.url.replace re, ''

                        servers[key].serve req, res, next
