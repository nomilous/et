class Ebb
    
    @configure : (opts = {}) ->

        @conf or= {}

        console.log "init ebb with ", opts

        return (req, res, next) -> 

            next()

module.exports = Ebb
