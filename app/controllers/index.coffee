`import Ember from 'ember'`

IndexController = Ember.Controller.extend
	scratchpadChanged: (->
		localStorage.setItem 'scratchpad', @get 'model.scratchpad'
	).observes 'model.scratchpad'

	gridBinding: 'model.grid'

	gridChanged: (->
		localStorage.setItem 'grid', @get('grid').join('\n')
	).observes 'grid'

	actions:
		play: ->
			console.log "Play!"
		clearConsole: ->
			@get('model').set 'console', ""
		selectTemplate: (newgrid) ->
			@set 'grid', newgrid

`export default IndexController`
