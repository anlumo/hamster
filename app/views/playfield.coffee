`import Ember from 'ember'`

PlayfieldView = Ember.View.extend
	classNames: ["playfield"]

	updateHamsterPosition: (->
		hamster = Ember.$('.playfield_hamster')
		pos = @get 'controller.model.playfield.hamsterLocation'
		if not pos
			return

		transform = 'translate(' + (pos[0] * 32 + 16) + 'px, ' + (pos[1] * 32 + 16) + 'px) rotate(' + pos[2] + 'deg)'

		hamster.css 'transform', transform
		hamster.css '-webkit-transform', transform
		hamster.css '-moz-transform', transform
		hamster.css '-o-transform', transform
		hamster.css '-ms-transform', transform
	).observes 'controller.model.playfield.hamsterLocation'

	didInsertElement: (->
		@updateHamsterPosition()

		Ember.$('#' + @elementId).css 'width', @get 'controller.playfieldwidth'
		Ember.$('#' + @elementId).css 'height', @get 'controller.playfieldheight'
	).observes 'controller.playfieldwidth', 'controller.playfieldheight'

`export default PlayfieldView`
