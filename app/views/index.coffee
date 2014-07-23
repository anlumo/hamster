`import Ember from 'ember'`

IndexView = Ember.View.extend
	templateName: 'index'

	didInsertElement: ->
		@_super()

		slider = Ember.$('.runSpeedSlider').slider(
			min: 0
			max: 2000
			value: @get 'controller.model.runSpeed'
			formater: (val) -> Math.round(val / 100) / 10 + " s"
		).on 'slide', =>
			value = slider.data('slider').getValue()
			@get('controller.model').set 'runSpeed', value

`export default IndexView`
