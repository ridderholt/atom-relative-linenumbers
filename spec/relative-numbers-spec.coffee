{WorkspaceView} = require 'atom'
RelativeNumbers = require '../lib/relative-numbers'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "RelativeNumbers", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('relative-numbers')

  describe "when the relative-numbers:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.relative-numbers')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'relative-numbers:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.relative-numbers')).toExist()
        atom.workspaceView.trigger 'relative-numbers:toggle'
        expect(atom.workspaceView.find('.relative-numbers')).not.toExist()
