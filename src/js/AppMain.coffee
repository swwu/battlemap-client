require('../css/main.scss')

Backbone = require('backbone')
React = require('react')
$ = require('jquery')
_ = require('underscore')

CharacterSheet = require('./components/CharacterSheet')

Entity = require('./models/Entity')

$( =>

  store = new Entity.Store("testspace")
  entity = new Entity.Model({id:"test"}, store)
  entity.fetch((err, cb) =>
    React.render(
      React.createElement(CharacterSheet, {entityModel: entity})
      document.getElementById("app-container")
    )
  )
)

