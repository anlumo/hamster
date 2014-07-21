`import Ember from 'ember'`

CornView = Ember.View.extend
	corncount: 1

	didInsertElement: (->
		location = @get 'location'
		div = Ember.$('#' + @elementId)

		div.attr 'class', 'playfield_corn' + @get('corncount') + ' playfield_cell'

		transform = 'translate(' + (location[0] * 32 + 16) + 'px, ' + (location[1] * 32 + 16) + 'px)'
		div.css 'transform', transform
		div.css '-webkit-transform', transform
		div.css '-moz-transform', transform
		div.css '-o-transform', transform
		div.css '-ms-transform', transform
	).observes 'location'


`export default CornView`
