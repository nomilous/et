class Thing

    @get: (req, res) -> 

        get: "from db with #{ req.params.id }"

module.exports = Thing