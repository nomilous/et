et
==

effortlessness <i>et al.</i>

Usage
-----


### thing.coffee

```coffee
class Thing

    @get: (id) -> 

        the: 'route /things/:id was defined'
        because: 'the model defined get(id)'
        uTodo: "get thing:#{id} from db"

module.exports = Thing
```


### server.coffee

```coffee
app  = require('express')()
rest = require('et').Rest

app.use rest.config
    app: app
    models:
        things: require './thing'

app.listen 3000
```


### result

<pre>
$ coffee server
...
$ curl http://localhost:3001/things/1234

{
  "the": "route /things/:id was defined",
  "because": "the model defined get(id)",
  "uTodo": "get thing:1234 from db"
}

</pre>


Changelog
---------

### 2012-12-09 (0.0.1)

* Added support for http GET to Ebb.Rest
* Transparently plugin to [express'](https://github.com/visionmedia/express) routing

