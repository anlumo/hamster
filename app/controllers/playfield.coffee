`import Ember from 'ember'`

PlayfieldController = Ember.Controller.extend
	setup: ->
		if @setupDone
			return
		@setupDone = true
		window.Hub.subscribe 'hamsterForward', @forward.bind this
		window.Hub.subscribe 'hamsterTurnLeft', @turnLeft.bind this
		window.Hub.subscribe 'hamsterTurnRight', @turnRight.bind this
		window.Hub.subscribe 'hamsterPickUp', @pickUp.bind this
		window.Hub.subscribe 'hamsterGive', @give.bind this
		window.Hub.subscribe 'hamsterCanMoveForward', @canMoveForward.bind this
		window.Hub.subscribe 'hamsterHasCorn', @hasCorn.bind this

	bricks: (->
		grid = @get 'model.playfield.grid'
		bricks = Ember.A()
		if not grid
			return bricks

		for y in [0...grid.length]
			line = grid[y]
			for x in [0...line.length]
				if line[x] == '#'
					bricks.push [x,y]

		return bricks
	).property 'model.playfield.grid'

	corn: (->
		grid = @get 'model.playfield.grid'
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
	).property 'model.playfield.grid'

	playfieldwidth: (->
		if not @get('model.playfield.grid')
			return 0
		(1+@get('model.playfield.grid')[0].length) * 32
	).property 'model.playfield.grid'

	playfieldheight: (->
		if not @get('model.playfield.grid')
			return 0
		(1+@get('model.playfield.grid').length) * 32
	).property 'model.playfield.grid'

	forwardLocation: ->
		hamsterLocation = @get 'model.playfield.hamsterLocation'
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
		if @get('model.playfield.grid')[y][x] == '#'
			throw new Error("Hit the wall!")

		@get('model.playfield').set 'hamsterLocation', [x, y, hamsterLocation[2]]

	turnLeft: ->
		hamsterLocation = Ember.copy @get('model.playfield.hamsterLocation'), true
		if hamsterLocation[2] > 0
			hamsterLocation[2] = hamsterLocation[2]-90
		else
			hamsterLocation[2] = 270
		@get('model.playfield').set 'hamsterLocation', hamsterLocation

	turnRight: ->
		hamsterLocation = Ember.copy @get('model.playfield.hamsterLocation'), true
		if hamsterLocation[2] < 270
			hamsterLocation[2] = hamsterLocation[2]+90
		else
			hamsterLocation[2] = 0
		@get('model.playfield').set 'hamsterLocation', hamsterLocation

	pickUp: ->
		hamsterLocation = @get 'model.playfield.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		grid = @get 'model.playfield.grid'

		cornCount = parseInt(grid[y][x], 13)
		if cornCount > 0
			line = grid[y]
			if cornCount == 1
				grid[y] = line.substr(0, x) + " " + line.substr(x + 1)
			else
				grid[y] = line.substr(0, x) + (cornCount-1).toString(13) + line.substr(x + 1)
			@get('model.playfield').incrementProperty 'carryCorn'
			@get('model.playfield').notifyPropertyChange 'grid'
		else
			throw new Error("Tried to pick up corn on an empty field.")

	give: ->
		hamsterLocation = @get 'model.playfield.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		grid = @get 'model.playfield.grid'

		cornCount = @get 'model.playfield.carryCorn'
		if cornCount > 0
			fieldCorn = parseInt(grid[y][x], 13)
			line = grid[y]
			if isNaN(fieldCorn)
				grid[y] = line.substr(0, x) + "1" + line.substr(x + 1)
			else if fieldCorn < 12
				grid[y] = line.substr(0, x) + (fieldCorn+1).toString(13) + line.substr(x + 1)

			@get('model.playfield').notifyPropertyChange 'grid'
			@get('model.playfield').decrementProperty 'carryCorn'
		else
			throw new Error("Tried to give corn, but don't have any.")

	hasCorn: (handler) ->
		hamsterLocation = @get 'model.playfield.hamsterLocation'
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		handler(not isNaN parseInt @get('model.playfield.grid')[y][x], 13)

	canMoveForward: (handler) ->
		hamsterLocation = @forwardLocation()
		x = hamsterLocation[0]
		y = hamsterLocation[1]
		handler(@get('model.playfield.grid')[y][x] != '#')

`export default PlayfieldController`
