class Ebb
    
    @configure : (app, config) ->

        console.log "init ebb with ", config

        return (req, res, next) -> next()

module.exports = Ebb
