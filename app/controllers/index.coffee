`import Ember from 'ember'`

IndexController = Ember.Controller.extend
	scratchpadChanged: (->
		localStorage.setItem 'scratchpad', @get 'model.scratchpad'
	).observes 'model.scratchpad'
	actions:
		play: ->
			console.log "Play!"
		clearConsole: ->
			@get('model').set 'console', ""

`export default IndexController`
