class Thing

    @get: (id) -> 

        the: 'route /things/:id was defined'
        because: 'the model defined get(id)'
        uTodo: "get thing:#{id} from db"

module.exports = Thing