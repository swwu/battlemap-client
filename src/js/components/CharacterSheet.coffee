React = require('react')

{div} = React.DOM

PrimaryStatContainer = require('./PrimaryStatContainer')

CharacterSheet = React.createClass({
  displayName: "CharacterSheet"
  render: ->
    attributes = ["str","dex","con","int","wis","cha"]

    reactEls = for attribute in attributes
      React.createElement(PrimaryStatContainer,
        {
          attr: attribute
          entityModel: @props.entityModel
        })

    div(null, reactEls...)
})

module.exports = CharacterSheet
