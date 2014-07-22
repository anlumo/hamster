`import Ember from 'ember'`

EditorController = Ember.Controller.extend
	init: ->
		context = window.require('debugjs').createDebugger
			sandbox:
				print: (text) ->
					window.Hub.publish 'logHTML', text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>")
		context.machine.on 'error', (e) =>
			location = context.getCurrentLoc()
			@set 'selection',
				start:
					column: location.start.column
					row: location.start.line - 1
				end:
					column: location.end.column
					row: location.end.line - 1

			window.Hub.publish 'logHTML', '<span class="error">Error in line ' + location.start.line + ': <em>' + e.message.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>") + '</em></span>'

		@set 'context', context
		window.Hub.subscribe 'play', => @play()

	play: ->
		text = @get 'model.scratchpad'
		context = @get 'context'

		context.load text, 'scratchpad.js'
		context.run()

`export default EditorController`
