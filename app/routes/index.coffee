`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
	model: ->
		scratchpad = localStorage.getItem('scratchpad')
		if not scratchpad
			scratchpad = "\n\n\n"
		return Ember.Object.create
			scratchpad: scratchpad
			console: "Hello World"

`export default IndexRoute`
