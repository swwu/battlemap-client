Backbone = require('backbone')
React = require('react')
$ = require('jquery')

{div} = React.DOM

CharacterSheetView = Backbone.View.extend({
  tagName: "div"

  initialize: ({entityModel}) ->
    @entityModel = entityModel

  render: ->
    attributes = ["str","dex","con","int","wis","cha"]

    reactEls = for attribute in attributes
      el = React.createElement(PrimaryStatContainer, {entityModel: @entityModel})
      el.setState(@model.getStat(attribute))
      el

    React.render(
      div(null, reactEls...)
      @el
    )
    return @
e)
