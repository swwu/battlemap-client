React = require('react')
_ = require('underscore')

{div, label, input} = React.DOM

# handles primary stats like str, dex, con, etc
# props:
#   entityModel - the model of the entity whose stats we want to show
#   attr - the specific stat we want to show. Will try to read attr, attr_base, and
#   attr_mod variables
PrimaryStatContainer = React.createClass({
  displayName: "PrimaryStatContainer"

  getInitialState: ->
    return {empty: false}

  # dummy method to allow proper cleanup of backbone model listener
  _forceUpdate: ->
    @forceUpdate()

  componentDidMount: ->
    @props.entityModel.on('change', @_forceUpdate)

  componentWillUnmount: ->
    @props.entityModel.off('change', @_forceUpdate)

  handleChange: (e) ->
    value = parseInt(e.target.value)
    if isNaN(value)
      @props.entityModel.setBaseValue("#{@props.attr}_base", 0)
      @setState({empty: true})
    else
      @props.entityModel.setBaseValue("#{@props.attr}_base", value)
      @setState({empty: false})

  render: ->
    attrLabel = @props.entityModel.getVarDesc(@props.attr).short
    attrBase = @props.entityModel.getBaseValue("#{@props.attr}_base")
    attrVal = @props.entityModel.getVar(@props.attr)
    attrMod = @props.entityModel.getVar("#{@props.attr}_mod")
    if @state.empty
      attrBase = ""
    return div({className: "primaryStatContainer"},
      label({className: "statLabel"}, attrLabel),
      input({type: "text", value: attrBase, onChange: @handleChange}),
      label({className: "finalValue"}, attrVal),
      label({className: "modifier"}, "#{if attrMod >= 0 then "+" else ""}#{attrMod}"),
    )
})

module.exports = PrimaryStatContainer
