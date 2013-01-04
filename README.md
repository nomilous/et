et
==

effortlessness, serverside <i>et al.</i>


    $ npm install et
    



Usage
-----

This example uses [jugglingdb](https://github.com/1602/jugglingdb) to provide schema based database access

### thing.coffee

```coffee

module.exports = 

    config: (opts) -> 

        opts.resource.database1.define 'things'

            id: Number
            name: String
            location: String

    get: (req, res) ->

        Thing = req._et.resource.database1.models.thing

        Thing.find req.params.id, (arg1, data, arg3) -> 

            res.send data


```


### server.coffee

```coffee

app     = require('express')()
et      = require('et')
Schema  = require('jugglingdb').Schema

app.use et.al

    app: app

    resource:

        database1: new Schema 'postgres'

            host: 'db.domain.com',
            database: 'dbname',
            username: 'dbuser',
            password: 'passrod'

    models:

        things: require './thing'


app.listen 3001


```


### result

```coffee

$ coffee server
...
$ curl http://localhost:3001/things/1

{
    "id": 1
    "name": "Venus of Hohle Fels"
    "location": "Schelklingen, Germany"
}

```

Develop
-------

### 2013-01-?? (0.0.3)

* Adding auto spawn a restify server if no app provided
* et.al( opts ) returns the running server


Changelog
---------

### 2012-12-12 (0.0.2)

* Added call to model.config (if present), to configure resources at startup
* Added opts.resource available at startup and on req._et.resource
* Added basic local auth using [passport](http://passportjs.org/) 
* Added basic redis session using [connect.session](http://www.senchalabs.org/connect/session.html) (very defaulty! See TODO in src/session)
* Added et.al() all encompasser

### 2012-12-09 (0.0.1)

* Added support for http GET to et
* Transparently plugin to [express'](https://github.com/visionmedia/express) routing

