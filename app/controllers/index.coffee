`import Ember from 'ember'`

IndexController = Ember.Controller.extend
	scratchpadChanged: (->
		localStorage.setItem 'scratchpad', @get 'model.scratchpad'
	).observes 'model.scratchpad'

	selectedTemplate: null

	playfieldChanged: (->
		localStorage.setItem 'carryCorn', @get('model.playfield.carryCorn')
		localStorage.setItem 'grid', @get('model.playfield.grid').join('\n')
		localStorage.setItem 'hamsterLocation', @get('model.playfield.hamsterLocation').join(',')
	).observes 'model.playfield', 'model.playfield.grid', 'model.playfield.carryCorn', 'model.playfield.hamsterLocation'

	actions:
		play: ->
			window.Hub.publish 'play'
		reset: ->
			@get('model').set 'playfield', @get 'selectedTemplate'
		clearConsole: ->
			@get('model').set 'console', ""
		selectTemplate: (template) ->
			@set 'selectedTemplate', template
			@get('model').set 'playfield', template

`export default IndexController`
