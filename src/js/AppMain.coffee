require('../css/main.scss')

Backbone = require('backbone')
React = require('react')
$ = require('jquery')

CharacterSheet = require('./components/CharacterSheet')

Entity = require('./models/Entity')

$( =>

  {EntityModel, EntityCollection} = Entity.withGamespace("testspace")
  entity = new EntityModel({id:"test"})
  entity.fetch({success: (entity, response, options) =>
    React.render(
      React.createElement(CharacterSheet, {entityModel: entity})
      document.getElementById("app-container")
    )
  })
)

