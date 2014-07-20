`import Ember from 'ember'`

AceEditorComponent = Ember.Component.extend
	didInsertElement: ->
		@editor = window.ace.edit "editor"
		@editor.setTheme "ace/theme/monokai"
		@editor.getSession().setMode "ace/mode/javascript"

		@editor.on "change", =>
			Ember.run.once this, @notifyPropertyChange, "content"

		if @preset
			@set "content", @preset
			@preset = null
	content: ((key, val) ->
		if !@editor
			@preset = val
			return val
		if arguments.length == 1
			return @editor.getSession().getValue()
		@editor.getSession().setValue val
		return val
	).property()

`export default AceEditorComponent`
