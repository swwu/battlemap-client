require('../css/main.scss')

Backbone = require('backbone')
React = require('react')
$ = require('jquery')
_ = require('underscore')

CharacterSheet = require('./components/CharacterSheet')

Entity = require('./models/Entity')

$( =>

  {EntityModel, EntityCollection} = Entity.withGamespace("testspace")
  entity = new EntityModel({id:"test"})
  entity.fetch({success: (entity, response, options) =>
    entity.on("change", =>
      console.log "ASDSADSADASD2"
    )

    setInterval( =>
      entity.save()
    , 2000)

    React.render(
      React.createElement(CharacterSheet, {entityModel: entity})
      document.getElementById("app-container")
    )
  })
)

