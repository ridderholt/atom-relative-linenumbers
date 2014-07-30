{View} = require 'atom'

module.exports =
class RelativeNumbersView extends View
  @content: ->
    @div class: 'relative-numbers overlay from-top', =>
      @div "The RelativeNumbers package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "relative-numbers:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "RelativeNumbersView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
