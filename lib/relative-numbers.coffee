{$} = require 'atom'
events = [ 'core:move-up', 'vim-mode:move-up', 'core:move-down', 'vim-mode:move-down' ]

module.exports =

  activate: (state) ->
    atom.workspaceView.eachEditorView (editor) =>
      @_recalculateLineNumbers(editor.getEditor().getCursorScreenRow(), editor.getEditor().getLineCount())
      editor.on events.join(' '), =>
        atom.workspaceView.eachEditorView (editorView) =>
          @_recalculateLineNumbers(editorView.getEditor().getCursorScreenRow(), editorView.getEditor().getLineCount())

  _recalculateLineNumbers: (currentLineNumber, totalLines) ->
    currentRow = @_getRowElementByLineNumber(currentLineNumber)
    @_setNewRowNumber(currentRow, 0)
    @_recalculateBeforeCurrentRow(currentLineNumber)
    @_recalculateAfterCurrentRow(currentLineNumber, totalLines)

  _getRowElementByLineNumber: (lineNumber) ->
    $('.line-number[data-screen-row="' + lineNumber + '"]')

  _setNewRowNumber: (rowElement, newNumber) ->
    $(rowElement).html('&nbsp;' + newNumber + '<div class="icon-right"></div>')

  _recalculateBeforeCurrentRow: (currentLineNumber) ->
    counter = 1
    start = currentLineNumber - 1
    for i in [start...-1]
      row = @_getRowElementByLineNumber(i)
      @_setNewRowNumber(row, counter++)

  _recalculateAfterCurrentRow: (currentLineNumber, totalLine) ->
    counter = 1
    start = currentLineNumber + 1
    for i in [start...totalLine]
      row = @_getRowElementByLineNumber(i)
      @_setNewRowNumber(row, counter++)
