jasmine = require 'jasmine-node'
Ebb     = require '../lib/Ebb'

describe 'Ebb', -> 

    it 'defines Ebb.Rest', -> 

        expect( Ebb.Rest ).toBeDefined