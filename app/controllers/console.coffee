`import Ember from 'ember'`

ConsoleController = Ember.Controller.extend
	setupDone: false
	setup: ->
		Ember.run.next ->
			consoleElement = Ember.$('.console-wrapper')
			consoleElement.scrollTop consoleElement.prop 'scrollHeight'

		if @setupDone
			return
		@setupDone = true
		window.Hub.subscribe 'logHTML', this, @logHTML

	logHTML: (line) ->
			logLines = @get 'model.logLines'
			consoleElement = Ember.$('.console-wrapper')
			isScrolledBottom = Math.abs(consoleElement.scrollTop() + consoleElement.innerHeight() - consoleElement[0].scrollHeight) < 4

			logLines.pushObject line

			localStorage.setItem 'logLines', JSON.stringify logLines

			if isScrolledBottom
				Ember.run.next ->
					consoleElement.scrollTop consoleElement.prop 'scrollHeight'

`export default ConsoleController`
