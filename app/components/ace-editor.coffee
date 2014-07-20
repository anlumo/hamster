`import Ember from "ember"`

AceEditorComponent = Ember.Component.extend
	classNames: ['editor']

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

		@editor.on 'change', =>
			@notifyPropertyChange 'content'

		if @preset
			@set 'content', @preset
			@preset = null

			@resizeView()

	resizeView: (->
		renderer = @editor.renderer;
		newHeight = @editor.getSession().getScreenLength() * renderer.lineHeight + renderer.scrollBar.getWidth()
		newHeight = Math.max newHeight, 200
		Ember.$("#" + this.elementId).height newHeight.toString()
		@editor.resize()
	).observes 'content'

`export default AceEditorComponent`
