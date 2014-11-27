React = require('react')
_ = require('underscore')

{div, label} = React.DOM

# handles stats that display all the bonuses that are added together
# props:
#   entityModel - the model of the entity whose stats we want to show
#   mainVar - {varAccessor, label}. varAccessor is either a function which
#   will be called with (entityModel) as its arg, and the return value will be
#   used, or is a value, which will be used as a variable name to retrieve a
#   value from entityModel
#   varList - list of stats / descriptive text for each:
#   [{varAccessor, label},...]
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
    mainVarAccessor = @props.mainVar.varAccessor
    mainLabel = @props.mainVar.label

    getAccessorVal = (acc) =>
      if _.isFunction(acc)
        return acc(@props.entityModel)
      else
        return @props.entityModel.getVar(acc)

    $statBoxes = for {varAccessor, label} in @props.varList
      div({className:"statBox"}, getAccessorVal(varAccessor))

    return div({className: "additiveStatContainer"},
      React.DOM.label({className:"statBoxLabel"}, mainLabel),
      div({className:"statBox"},
        getAccessorVal(mainVarAccessor)),
      $statBoxes...
    )
})

module.exports = AdditiveStatContainer
