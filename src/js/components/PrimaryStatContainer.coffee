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
    setObj = {}
    setObj["#{@props.attr}_base"] = e.target.value
    @props.entityModel.setVars(setObj)

  render: ->
    attrLabel = @props.entityModel.getStatDesc(@props.attr).short
    attrVal = @props.entityModel.getVar(@props.attr)
    attrBase = @props.entityModel.getVar("#{@props.attr}_base")
    attrMod = @props.entityModel.getVar("#{@props.attr}_mod")
    div({className: "primaryStatContainer"},
      label({className: "statLabel"}, attrLabel),
      input({type: "text", value: attrBase, onChange: @handleChange}),
      label({className: "finalValue"}, attrVal),
      label({className: "modifier"}, "#{if attrMod > 0 then "+" else ""}#{attrMod}"),
    )
})

module.exports = PrimaryStatContainer
