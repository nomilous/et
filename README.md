et
==

effortlessness, serverside <i>et al.</i>

Usage
-----


### thing.coffee

```coffee
class Thing

    @get: (id) -> 

        todo: "get thing:#{id} from db"

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

app.listen 3001
```


### result

<pre>
$ coffee server
...
$ curl http://localhost:3001/things/12345

{
  "todo": "get thing:12345 from db"
}

</pre>


Changelog
---------

### 2012-12-09 (0.0.1)

* Added support for http GET to Ebb.Rest
* Transparently plugin to [express'](https://github.com/visionmedia/express) routing

