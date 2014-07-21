`import Ember from 'ember'`

BrickView = Ember.View.extend
	classNames: ['playfield_brick', 'playfield_cell']

	didInsertElement: (->
		location = @get 'location'
		div = Ember.$('#' + @elementId)

		transform = 'translate(' + (location[0] * 32 + 16) + 'px, ' + (location[1] * 32 + 16) + 'px)'
		div.css 'transform', transform
		div.css '-webkit-transform', transform
		div.css '-moz-transform', transform
		div.css '-o-transform', transform
		div.css '-ms-transform', transform
	).observes 'location'

`export default BrickView`
