`import Ember from 'ember'`

PlayfieldController = Ember.Controller.extend
	# max: 21x13
	grid: [
		'#####################',
		'#                   #',
		'#               #   #',
		'#>11111        #1#  #',
		'#     11      #111# #',
		'#      1   11111111##',
		'#      1   1  #111# #',
		'#      1  11   #1#  #',
		'#      1111     #   #',
		'#####################'
	]

	bricks: (->
		grid = @get 'grid'
		bricks = Ember.A()

		for y in [0...grid.length]
			line = grid[y]
			for x in [0...line.length]
				if line[x] == '#'
					bricks.push [x,y]

		return bricks
	).property 'grid'

	corn: (->
		grid = @get 'grid'
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
	).property 'grid'

	playfieldwidth: (->
		(1+@get('grid')[0].length) * 32
	).property 'grid'

	playfieldheight: (->
		(1+@get('grid').length) * 32
	).property 'grid'

`export default PlayfieldController`
