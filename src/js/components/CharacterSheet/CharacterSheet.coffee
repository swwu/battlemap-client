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
      do (st) =>
        React.createElement(AdditiveStatContainer,
          {
            entityModel: @props.entityModel
            mainVar: {
              varAccessor: st
              label: st
            }
            varList: [{
              varAccessor: "#{st}_base"
              label: "Base"
            },{
              varAccessor: "#{st}_abmod_bonus"
              label: "Ability"
            },{
              varAccessor: (entityModel) ->
                entityModel.getVar(st) - (entityModel.getVar("#{st}_base") + entityModel.getVar("#{st}_abmod_bonus"))
              label: "Misc"
            }]
          })

    div(null, $primaryBoxes..., $saveBoxes...)
})

module.exports = CharacterSheet
