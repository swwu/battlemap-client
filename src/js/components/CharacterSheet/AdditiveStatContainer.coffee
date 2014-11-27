React = require('react')
_ = require('underscore')

{div, label} = React.DOM

# handles stats that display all the bonuses that are added together
# props:
#   entityModel - the model of the entity whose stats we want to show
#   mainVar - {varName, label}
#   varList - list of stats / descriptive text for each:
#   [{varName, label},...]
AdditiveStatContainer = React.createClass({
  displayName: "AdditiveStatContainer"

  # dummy method to allow proper cleanup of backbone model listener
  _forceUpdate: ->
    @forceUpdate()

  componentDidMount: ->
    @props.entityModel.on('change', @_forceUpdate)

  componentWillUnmount: ->
    @props.entityModel.off('change', @_forceUpdate)

  render: ->
    mainVar = @props.mainVar.varName
    mainLabel = @props.mainVar.label

    $statBoxes = for {varName, label} in @props.varList
      div({className:"statBox"}, @props.entityModel.getVar(varName))

    return div({className: "additiveStatContainer"},
      div({className:"statBox"}, @props.entityModel.getVar(mainVar)),
      $statBoxes...
    )
})

module.exports = AdditiveStatContainer
