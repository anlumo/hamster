`import Ember from 'ember'`

ConsoleController = Ember.Controller.extend
	init: ->
		Ember.run.later =>
			@get('model').set 'logLines', Ember.A()
		window.Hub.subscribe 'logHTML', (line) =>
			logLines = @get 'model.logLines'
			logLines.pushObject line

`export default ConsoleController`
