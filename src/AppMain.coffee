Backbone = require('backbone')
React = require('react')
$ = require('jquery')

CharacterSheet = require('./components/CharacterSheet')
Entity = require('./models/Entity')

server = "http://localhost:10010/gamespace/testspace/entity/test"

$( =>
  $.getJSON(server, (entityVars) =>
    entity = new Entity(entityVars)

    console.log entity.getStat("str")
  )
  React.render(
    React.createElement(CharacterSheet, null)
    document.getElementById("box")
  )
)

