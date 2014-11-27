React = require('react')

{div} = React.DOM

PrimaryStatContainer = require('./PrimaryStatContainer')
AdditiveStatContainer = require('./AdditiveStatContainer')

CharacterSheet = React.createClass({
  displayName: "CharacterSheet"
  render: ->
    attributes = ["str","dex","con","int","wis","cha"]

    $primaryBoxes = for attribute in attributes
      React.createElement(PrimaryStatContainer,
        {
          attr: attribute
          entityModel: @props.entityModel
        })

    $saveBoxes = for st in ["fort_save", "ref_save", "will_save"]
      React.createElement(AdditiveStatContainer,
        {
          entityModel: @props.entityModel
          mainVar: {
            varName: st
            label: st
          }
          varList: [{
            varName: "#{st}_base"
            label: "Base #{st}"
          }]
        })

    div(null, $primaryBoxes..., $saveBoxes...)
})

module.exports = CharacterSheet
