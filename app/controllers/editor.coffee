`import Ember from 'ember'`

EditorController = Ember.Controller.extend
	setupDone: false
	setup: ->
		if @setupDone
			return
		@setupDone = true
		scope =
			schreib: (text) ->
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
			maulLeer: =>
				return @get('model.playfield.carryCorn') == 0

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
		window.Hub.subscribe 'play', this, @play
		window.Hub.subscribe 'pause', this, @pause
		window.Hub.subscribe 'stop', this, @stop
		window.Hub.subscribe 'stepIn', this, @stepIn
		window.Hub.subscribe 'stepOver', this, @stepOver

	runSpeedChanged: (->
		localStorage.setItem 'runSpeed', @get 'model.runSpeed'
	).observes 'model.runSpeed'

	highlightLine: null

	running: false

	updateVariables: ->
		stack = @context.getCallStack()
		frame = stack[stack.length-1]
		scope = frame.scope;

		variables = Ember.A()

		for obj in scope
			value = frame.evalInScope(obj.name)
			variables.push
				name: obj.name
				description: JSON.stringify value
		@get('model').set 'variables', variables

	playModeTimer: null
	play: ->
		context = @get 'context'
		@get('model').set 'playMode', true

		timer = =>
			@stepIn()
			if not context.machine.halted
				@playModeTimer = Ember.run.later this, timer, @get 'model.runSpeed' # runSpeed might have changed since the last time
			else
				@get('model').set 'playMode', false
		timer()

	pause: ->
		if @playModeTimer
			Ember.run.cancel @playModeTimer
			@get('model').set 'playMode', false

	stop: ->
		context = @get 'context'
		@set 'running', false
		@get('model').set 'playMode', false
		@set 'highlightRange', null
		if @playModeTimer
			Ember.run.cancel @playModeTimer

	step: (type) ->
		context = @get 'context'
		try
			if @get 'running'
				context[type]()
			else
				text = @get 'model.scratchpad'
				context.load text, 'scratchpad.js'
				context.machine.step()
			@updateVariables()
		catch e
			# js compiler error!

			@set 'selection',
				start:
					column: 0
					row: e.lineNumber - 1
				end:
					column: 0
					row: e.lineNumber

			window.Hub.publish 'logHTML', '<span class="error"><em>' + e.message.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>") + '</em></span>'
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
