React = require('react')
_ = require('underscore')

{div, label, input} = React.DOM

PrimaryStatContainer = React.createClass({
  displayName: "PrimaryStatContainer"

  # dummy method to allow proper cleanup of backbone model listener
  _forceUpdate: ->
    @forceUpdate()

  componentDidMount: ->
    @props.entityModel.on('change', @_forceUpdate)

  componentWillUnmount: ->
    @props.entityModel.off('change', @_forceUpdate)

  handleChange: (e) ->
    @props.entityModel.setBaseValue("#{@props.attr}_base", parseInt(e.target.value))

  render: ->
    attrLabel = @props.entityModel.getStatDesc(@props.attr).short
    attrBase = @props.entityModel.getBaseValue("#{@props.attr}_base")
    attrVal = @props.entityModel.getVar(@props.attr)
    attrMod = @props.entityModel.getVar("#{@props.attr}_mod")
    div({className: "primaryStatContainer"},
      label({className: "statLabel"}, attrLabel),
      input({type: "text", value: attrBase, onChange: @handleChange}),
      label({className: "finalValue"}, attrVal),
      label({className: "modifier"}, "#{if attrMod > 0 then "+" else ""}#{attrMod}"),
    )
})

module.exports = PrimaryStatContainer
