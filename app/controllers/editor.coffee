`import Ember from 'ember'`

EditorController = Ember.Controller.extend
	init: ->
		scope =
			print: (text) ->
				window.Hub.publish 'logHTML', text.toString().replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>")
			vor: ->
				window.Hub.publish 'hamsterForward'
			linksUm: ->
				window.Hub.publish 'hamsterTurnLeft'
			rechtsUm: ->
				window.Hub.publish 'hamsterTurnRight'
			nimm: ->
				window.Hub.publish 'hamsterPickUp'
			gib: ->
				window.Hub.publish 'hamsterGive'
			vorneFrei: ->
				result = false
				window.Hub.publish 'hamsterCanMoveForward', (can) ->
					result = can
				result
			kornDa: ->
				result = false
				window.Hub.publish 'hamsterHasCorn', (has) ->
					result = has
				result

		context = window.require('debugjs').createDebugger
			sandbox: scope
		context.machine.on 'error', (e) =>
			location = context.getCurrentLoc()
			if location
				@set 'selection',
					start:
						column: location.start.column
						row: location.start.line - 1
					end:
						column: location.end.column
						row: location.end.line - 1

				window.Hub.publish 'logHTML', '<span class="error">Error in line ' + location.start.line + ': <em>' + e.message.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>") + '</em></span>'
			else
				window.Hub.publish 'logHTML', '<span class="error">Error: <em>' + e.message.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>") + '</em></span>'

		@set 'context', context
		window.Hub.subscribe 'play', @play.bind this
		window.Hub.subscribe 'stop', @stop.bind this
		window.Hub.subscribe 'stepIn', @stepIn.bind this
		window.Hub.subscribe 'stepOver', @stepOver.bind this

	highlightLine: null

	running: false

	play: ->
		text = @get 'model.scratchpad'
		context = @get 'context'

		context.load text, 'scratchpad.js'
		context.run()
		@set 'running', false

	stop: ->
		context = @get 'context'
		@set 'running', false
		@set 'highlightRange', null

	step: (type) ->
		context = @get 'context'
		try
			if @get 'running'
				context[type]()
			else
				text = @get 'model.scratchpad'
				context.load text, 'scratchpad.js'
				context.machine.step()
		finally
			running = not context.machine.halted
			@set 'running', running
			if running
				location = context.machine.getCurrentLoc()
				@set 'highlightRange',
					start:
						column: location.start.column
						row: location.start.line - 1
					end:
						column: location.end.column
						row: location.end.line - 1
			else
				@set 'highlightRange', null

	stepIn: ->
		@step "stepIn"

	stepOver: ->
		@step "stepOver"

`export default EditorController`
