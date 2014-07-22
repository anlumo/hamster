`import Ember from 'ember'`

IndexController = Ember.Controller.extend
	init: ->
		template = localStorage.getItem 'selectedTemplate'
		@set 'selectedTemplate', JSON.parse(template)

	scratchpadChanged: (->
		localStorage.setItem 'scratchpad', @get 'model.scratchpad'
	).observes 'model.scratchpad'

	selectedTemplate: null

	gridChanged: (->
		localStorage.setItem 'grid', @get('model.playfield.grid').join('\n')
	).observes 'model.playfield.grid'

	carryCornChanged: (->
		localStorage.setItem 'carryCorn', @get('model.playfield.carryCorn')
	).observes 'model.playfield.carryCorn'

	hamsterLocationChanged: (->
		localStorage.setItem 'hamsterLocation', @get('model.playfield.hamsterLocation').join(',')
	).observes 'model.playfield.hamsterLocation'

	actions:
		play: ->
			window.Hub.publish 'play'
		reset: ->
			@get('model').set 'playfield', Ember.Object.create Ember.copy @get('selectedTemplate'), true
		rotate: ->
			window.Hub.publish 'hamsterTurnLeft'
		clearConsole: ->
			@get('model').set 'console', ""
		selectTemplate: (template) ->
			localStorage.setItem 'selectedTemplate', JSON.stringify(template)
			@set 'selectedTemplate', template
			@get('model').set 'playfield', Ember.Object.create Ember.copy template, true

`export default IndexController`
