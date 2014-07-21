`import Ember from 'ember'`

PlayfieldController = Ember.Controller.extend
	bricks: (->
		grid = @get 'model'
		bricks = Ember.A()

		for y in [0...grid.length]
			line = grid[y]
			for x in [0...line.length]
				if line[x] == '#'
					bricks.push [x,y]

		return bricks
	).property 'model'

	corn: (->
		grid = @get 'model'
		corn = Ember.A()

		for y in [0...grid.length]
			line = grid[y]
			for x in [0...line.length]
				corncount = parseInt(line[x], 13)
				if not isNaN(corncount) and corncount > 0
					corn.push Ember.Object.create
						location: [x,y]
						count: parseInt(line[x], 13)

		return corn
	).property 'model'

	playfieldwidth: (->
		(1+@get('model')[0].length) * 32
	).property 'model'

	playfieldheight: (->
		(1+@get('model').length) * 32
	).property 'model'

	hamsterposition: (->
		grid = @get 'model'

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
		return [location, rotation]
	).property 'model'

`export default PlayfieldController`
