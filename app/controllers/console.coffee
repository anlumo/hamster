`import Ember from 'ember'`

ConsoleController = Ember.Controller.extend
	init: ->
		Ember.run.later =>
			@get('model').set 'logLines', Ember.A()
		window.Hub.subscribe 'logHTML', (line) =>
			logLines = @get 'model.logLines'
			consoleElement = Ember.$('.console-wrapper')
			isScrolledBottom = Math.abs(consoleElement.scrollTop() + consoleElement.innerHeight() - consoleElement[0].scrollHeight) < 4

			logLines.pushObject line

			if isScrolledBottom
				Ember.run.next ->
					consoleElement.scrollTop consoleElement.prop 'scrollHeight'

`export default ConsoleController`
