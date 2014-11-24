require('../css/main.scss')

Backbone = require('backbone')
React = require('react')
$ = require('jquery')

CharacterSheet = require('./components/CharacterSheet')
Entity = require('./models/Entity')

server = "http://localhost:10010/gamespace/testspace/entity/test"

$( =>
  $.getJSON(server, (entityVars) =>
    entity = new Entity(entityVars)

    window.entity = entity
    React.render(
      React.createElement(CharacterSheet, {entityModel: entity})
      document.getElementById("app-container")
    )
  )
)

