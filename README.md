et
==

effortlessness, serverside <i>et al.</i>

Usage
-----


### thing.coffee

```coffee
class Thing

    @get: (req, res) -> 

        todo: "get thing:#{ req.params.id} from db"

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

* Added schema based database access mech (up to model defn to use it), suggests [jugglingdb](https://github.com/1602/jugglingdb)
* Added basic local auth using [passport](http://passportjs.org/) 
* Added basic redis session using [connect.session](http://www.senchalabs.org/connect/session.html) (very defaulty! See TODO in src/session)
* Added et.al() all encompasser

### 2012-12-09 (0.0.1)

* Added support for http GET to Ebb.Rest
* Transparently plugin to [express'](https://github.com/visionmedia/express) routing

