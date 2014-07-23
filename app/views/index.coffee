`import Ember from 'ember'`

IndexView = Ember.View.extend
	templateName: 'index'

	didInsertElement: ->
		@_super()

		console.log Ember.$('.runSpeedSlider')
		Ember.$('.runSpeedSlider').slider
			min: 0
			max: 5000
			value: 1000
			formater: (val) -> val + " ms"

`export default IndexView`
