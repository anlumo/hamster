`import Ember from "ember"`

AceEditorComponent = Ember.Component.extend
	classNames: ['editor']

	readonly: false
	highlightRange: null

	cursorPosition: ((key, val) ->
		if !@editor
			return {row: 0, column: 0}

		if arguments.length == 1
			return @editor.selection.getCursor()

		@editor.selection.clearSelection()
		@editor.selection.moveCursorToPosition val
		@editor.focus()

		val
	).property()

	selection: ((key, val) ->
		if !@editor
			return {}

		if arguments.length == 1
			return @editor.selection.getRange()

		@editor.selection.setSelectionRange val, true
		@editor.focus()

		val
	).property()

	content: ((key, val) ->
		if !@editor
			@preset = val
			return val

		if arguments.length == 1
			return @editor.getSession().getValue()

		cursor = @editor.getCursorPosition()
		@editor.getSession().setValue val
		@editor.moveCursorToPosition cursor
		return val
	).property()

	didInsertElement: ->
		@editor = window.ace.edit @elementId
		@editor.getSession().setMode 'ace/mode/javascript'
		@editor.setShowPrintMargin false
		@editor.setHighlightActiveLine true
		@editor.getSession().setUseWrapMode true

		@editor.on 'change', =>
			@notifyPropertyChange 'content'
		@editor.getSession().selection.on 'changeCursor', =>
			@notifyPropertyChange 'cursorPosition'
		@editor.getSession().selection.on 'changeSelection', =>
			@notifyPropertyChange 'selection'

		if @preset
			@set 'content', @preset
			@preset = null

			@resizeView()
		@editor.focus()

	resizeView: (->
		renderer = @editor.renderer;
		newHeight = @editor.getSession().getScreenLength() * renderer.lineHeight + renderer.scrollBar.getWidth()
		newHeight = Math.max newHeight, 200
		Ember.$("#" + this.elementId).css 'min-height', newHeight.toString() + "px"
		@editor.resize()
	).observes 'content'

	oldHighlightLine: null

	updateHighlightRange: (->
		if @oldHighlightLine != null
			@editor.getSession().removeGutterDecoration @oldHighlightLine, "currentLine"
		highlightRange = @get('highlightRange')
		if highlightRange
			@editor.getSession().addGutterDecoration highlightRange.start.row, "currentLine"
			@oldHighlightLine = highlightRange.start.row
		else
			@oldHighlightLine = null
	).observes 'highlightRange'

	readonlyChanged: (->
		readonly = @get 'readonly'
		@editor.setReadOnly readonly
		if readonly
			Ember.$('.ace_content').css 'background-color', '#ddd'
		else
			Ember.$('.ace_content').css 'background-color', 'white'
	).observes 'readonly'

`export default AceEditorComponent`
