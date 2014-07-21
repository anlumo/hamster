`import Ember from 'ember'`

PlayfieldView = Ember.View.extend
	classNames: ["playfield"]

	didInsertElement: (->
		hamster = Ember.$('.playfield_hamster')

		grid = @get 'controller.grid'

		rotation = 0
		location = (->
			for y in [0...grid.length]
				line = grid[y]
				for x in [0...line.length]
					switch line[x]
						when '>'
							rotation = 0
						when 'v'
							rotation = 90
						when '<'
							rotation = 180
						when '^'
							rotation = 270
						else
							continue
					return [x,y]
		)()

		transform = 'rotate(' + rotation + 'deg) translate(' + (location[0] * 32 + 16) + 'px, ' + (location[1] * 32 + 16) + 'px)'

		hamster.css 'transform', transform
		hamster.css '-webkit-transform', transform
		hamster.css '-moz-transform', transform
		hamster.css '-o-transform', transform
		hamster.css '-ms-transform', transform

		Ember.$('#' + @elementId).css 'width', @get 'controller.playfieldwidth'
		Ember.$('#' + @elementId).css 'height', @get 'controller.playfieldheight'
	).observes 'controller.grid'

`export default PlayfieldView`
