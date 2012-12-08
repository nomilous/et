app  = require('express')()
rest = require '../lib/rest' 

app.use rest.config
    app: app
    models:
        things: require './thing'

app.listen 3001
