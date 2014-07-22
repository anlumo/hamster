`import Ember from 'ember'`

PlayfieldController = Ember.Controller.extend
	bricks: (->
		grid = @get 'model.grid'
		bricks = Ember.A()
		if not grid
			return bricks

		for y in [0...grid.length]
			line = grid[y]
			for x in [0...line.length]
				if line[x] == '#'
					bricks.push [x,y]

		return bricks
	).property 'model.grid'

	corn: (->
		grid = @get 'model.grid'
		corn = Ember.A()
		if not grid
			return corn

		for y in [0...grid.length]
			line = grid[y]
			for x in [0...line.length]
				corncount = parseInt(line[x], 13)
				if not isNaN(corncount) and corncount > 0
					corn.push Ember.Object.create
						location: [x,y]
						count: parseInt(line[x], 13)

		return corn
	).property 'model.grid'

	playfieldwidth: (->
		if not @get('model.grid')
			return 0
		(1+@get('model.grid')[0].length) * 32
	).property 'model.grid'

	playfieldheight: (->
		if not @get('model.grid')
			return 0
		(1+@get('model.grid').length) * 32
	).property 'model.grid'

	forwardLocation: ->
		hamsterLocation = @get 'model.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]

		switch hamsterLocation[2]
			when 0
				x++
			when 90
				y++
			when 180
				x--
			when 270
				y--
		return [x, y, hamsterLocation[2]]

	forward: ->
		hamsterLocation = @forwardLocation()
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		if @get('model.grid')[y][x] == '#'
			throw new Error("Hit the wall!")

		@get('model').set 'hamsterLocation', [x, y, hamsterLocation[2]]

	turnLeft: ->
		hamsterLocation = @get('model.hamsterLocation').clone()
		if hamsterLocation[2] > 0
			hamsterLocation[2] = hamsterLocation[2]-90
		else
			hamsterLocation[2] = 270
		@get('model').set 'hamsterLocation', hamsterLocation

	turnRight: ->
		hamsterLocation = @get('model.hamsterLocation').clone()
		if hamsterLocation[2] < 270
			hamsterLocation[2] = hamsterLocation[2]+90
		else
			hamsterLocation[2] = 0
		@get('model').set 'hamsterLocation', hamsterLocation

	pickUp: ->
		hamsterLocation = @get 'model.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		grid = @get 'model.grid'

		cornCount = parseInt(grid[y][x], 13)
		if cornCount > 0
			grid[y][x] = (cornCount-1).toString(13)
			@get('model').incrementProperty 'carryCorn'
			@get('model').notifyPropertyChange 'grid'
		else
			throw new Error("Tried to pick up corn on empty field.")

	give: ->
		hamsterLocation = @get 'model.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		grid = @get 'model.grid'

		cornCount = @get 'model.carryCorn'
		if cornCount > 0
			fieldCorn = parseInt(grid[y][x], 13)
			if isNaN(fieldCorn)
				grid[y][x] = '1'
			else if fieldCorn < 12
				grid[y][x] = (fieldCorn+1).toString(13)

			@get('model').notifyPropertyChange 'grid'
			@get('model').decrementProperty 'carryCorn'
		else
			throw new Error("Tried to give corn, but don't have any.")

	hasCorn: ->
		hamsterLocation = @get 'model.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		not isNaN parseInt(@get('model.grid')[y][x], 13)

	canMoveForward: ->
		hamsterLocation = @forwardLocation()
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		@get('model.grid')[y][x] != '#'

`export default PlayfieldController`
