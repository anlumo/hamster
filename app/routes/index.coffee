`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
	model: ->
		scratchpad = localStorage.getItem('scratchpad')
		if not scratchpad
			scratchpad = "\n\n\n"
		grid = localStorage.getItem('grid')
		if not grid
			grid = ['###', '# #', '###']
		else
			grid = grid.split '\n'
		hamsterLocation = localStorage.getItem('hamsterLocation')
		if not hamsterLocation
			hamsterLocation = [1,1,0]
		else
			hamsterLocation = hamsterLocation.split(',').map (num) ->
				parseInt num
		carryCorn = parseInt localStorage.getItem('carryCorn')
		if not carryCorn
			carryCorn = 0
		logLines = localStorage.getItem('logLines')
		if not logLines
			logLines = Ember.A()
		else
			logLines = JSON.parse(logLines)
		runSpeed = localStorage.getItem 'runSpeed'
		if not runSpeed
			runSpeed = 500
		else
			runSpeed = parseInt runSpeed
		mainSplitview = localStorage.getItem 'mainSplitview'
		if not mainSplitview
			mainSplitview = 50
		else
			mainSplitview = parseInt mainSplitview
		mainSplitview = localStorage.getItem 'mainSplitview'
		if not mainSplitview
			mainSplitview = 50
		else
			mainSplitview = parseInt mainSplitview
		editorSplitview = localStorage.getItem 'editorSplitview'
		if not editorSplitview
			editorSplitview = 75
		else
			editorSplitview = parseInt editorSplitview
		playfieldSplitview = localStorage.getItem 'playfieldSplitview'
		if not playfieldSplitview
			playfieldSplitview = 75
		else
			playfieldSplitview = parseInt playfieldSplitview

		return Ember.Object.create
			scratchpad: scratchpad
			logLines: logLines
			runSpeed: runSpeed
			playMode: false
			mainSplitview: mainSplitview
			editorSplitview: editorSplitview
			playfieldSplitview: playfieldSplitview
			playfield: Ember.Object.create
				grid: grid
				hamsterLocation: hamsterLocation
				carryCorn: carryCorn
			playfieldTemplates: [
				{
					name: "Terrain 1"
					grid: [
						"####################"
						"#           #      #"
						"#     1 #   ###### #"
						"#### #  #  1#11111 #"
						"#   1 1     ###### #"
						"#  ### ######      #"
						"#11#               #"
						"####################"
					]
					hamsterLocation: [4, 2, 90]
					carryCorn: 0
				}
				{
					name: "Terrain 2"
					grid: [
						"########"
						"#      #"
						"#  11  #"
						"#  ### #"
						"#      #"
						"########"
					]
					hamsterLocation: [2, 3, 90]
					carryCorn: 4
				}
				{
					name: "Terrain 3"
					grid: [
						"#############"
						"#           #"
						"#           #"
						"#      #    #"
						"#     ###   #"
						"#    #####  #"
						"#   ####### #"
						"#############"
					]
					hamsterLocation: [2, 6, 0]
					carryCorn: 0
				}
				{
					name: "Terrain 4"
					grid: [
						"########"
						"# 222  #"
						"# ###  #"
						"# 222  #"
						"#      #"
						"########"
					]
					hamsterLocation: [1, 2, 90]
					carryCorn: 0
				}
				{
					name: "Terrain 5"
					grid: [
						"########"
						"#  #   #"
						"#   #  #"
						"#    # #"
						"########"
					]
					hamsterLocation: [6, 1, 90]
					carryCorn: 6
				}
				{
					name: "Terrain 6"
					grid: [
						"########"
						"#      #"
						"# #### #"
						"# # 1# #"
						"# # ## #"
						"# #    #"
						"# ######"
						"#      #"
						"########"
					]
					hamsterLocation: [6, 7, 180]
					carryCorn: 0
				}
				{
					name: "Terrain 7"
					grid: [
						"#####################"
						"   1 1111111   11 11#"
						"#1 1 1   1   1  1   #"
						"#1 1 1 1 1 111 11 1 #"
						"#1     1 1     11 1 #"
						"#  11111     111  1 #"
						"# 11   111 111 1 11 #"
						"#    1           11  "
						"#####################"
					]
					hamsterLocation: [0, 1, 0]
					carryCorn: 0
				}
				{
					name: "Terrain 8"
					grid: [
						"##############"
						"#            #"
						"#     #      #"
						"#1#   #1 #1  #"
						"#### #########"
						"#### #########"
						"####         #"
						"##############"
					]
					hamsterLocation: [11, 6, 180]
					carryCorn: 0
				}
				{
					name: "Terrain 9"
					grid: [
						"#####################"
						"#1111111111111111111#"
						"#1111 111111111 1111#"
						"#111 1 1111111 1 111#"
						"#11 111 11111 111 11#"
						"#1 11 11 111 11 11 1#"
						"# 11 1 11 1 11 1 11 #"
						"#1 11 11 111 11 11 1#"
						"#11 111 11111 111 11#"
						"#111 1 1111111 1 111#"
						"#1111 111111111 1111#"
						"#1111111111111111111#"
						"#####################"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 50
				}
				{
					name: "Terrain 10"
					grid: [
						"#####################"
						"#                   #"
						"#               #   #"
						"# 11111        #1#  #"
						"#     11      #111# #"
						"#      1   11111111##"
						"#      1   1  #111# #"
						"#      1  11   #1#  #"
						"#      1111     #   #"
						"#####################"
					]
					hamsterLocation: [1, 3, 0]
					carryCorn: 0
				}
				{
					name: "Terrain 11"
					grid: [
						"##########"
						"#        #"
						"##########"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 0
				}
				{
					name: "Terrain 12"
					grid: [
						"##########"
						"#   1 1  #"
						"##########"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 8
				}
				{
					name: "Terrain 13"
					grid: [
						"#########"
						"#### ####"
						"#### ####"
						"#       #"
						"#### ####"
						"#### ####"
						"#### ####"
						"#### ####"
						"#########"
					]
					hamsterLocation: [4, 3, 0]
					carryCorn: 1
				}
				{
					name: "Terrain 14"
					grid: [
						"#################"
						"#   #   #   #   #"
						"# # # # # # # ###"
						"# # # # # ### ###"
						"# # # ### ### ###"
						"# ### ### ### ###"
						"# ### ### ### ###"
						"# ### ### ### ###"
						"#               #"
						"#################"
					]
					hamsterLocation: [15, 8, 180]
					carryCorn: 4 # has to be 1, 2, 3 or 4 for the task!
				}
				{
					name: "Terrain 15"
					grid: [
						"#########"
						"#       #"
						"# 1#1#1 #"
						"# ##### #"
						"# 1###1 #"
						"# ##### #"
						"# 1#1#1 #"
						"#       #"
						"#########"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 0
				}
				{
					name: "Empty 21x5"
					grid: [
						"#####################"
						"#                   #"
						"#                   #"
						"#                   #"
						"#                   #"
						"#                   #"
						"#####################"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 100
				}
				{
					name: "Task 4.1"
					generator: ->
						corridorLength = Math.floor(Math.random() * 17) + 3
						{
							grid: [
								new Array(corridorLength + 3).join '#'
								'#' + (new Array(corridorLength + 1).join ' ') + '#'
								new Array(corridorLength + 3).join '#'
							]

							hamsterLocation: [ Math.floor(Math.random() * corridorLength) + 1, 1, Math.floor(Math.random() * 4) * 90 ]
							carryCorn: 0
						}
				}
				{
					name: "Task 4.2"
					generator: ->
						corridorLength = Math.floor(Math.random() * 17) + 3
						floor = '#'
						for i in [0...corridorLength]
							count = Math.floor(Math.random() * 12)
							if count == 0
								floor += ' '
							else
								floor += count.toString(13)

						{
							grid: [
								new Array(corridorLength + 3).join '#'
								floor + '#'
								new Array(corridorLength + 3).join '#'
							]

							hamsterLocation: [ Math.floor(Math.random() * corridorLength) + 1, 1, Math.floor(Math.random() * 4) * 90 ]
							carryCorn: 0
						}
				}
				{
					name: "Task 4.3/4.4"
					generator: ->
						size = [
							Math.floor(Math.random() * 17) + 3
							Math.floor(Math.random() * 17) + 3
						]
						grid = [ new Array(size[0] + 3).join '#' ]

						for y in [0...size[1]]
							floor = '#'
							for x in [0...size[0]]
								count = Math.floor(Math.random() * 12)
								if count == 0
									floor += ' '
								else
									floor += count.toString(13)
							grid.push floor + '#'
						grid.push grid[0]

						{
							grid: grid
							hamsterLocation: [ Math.floor(Math.random() * size[0]) + 1, Math.floor(Math.random() * size[1]) + 1, Math.floor(Math.random() * 4) * 90 ]
							carryCorn: 0
						}
				}
				{
					name: "Task 4.5"
					generator: ->
						mountainSize = Math.floor(Math.random() * 12) + 3
						size = [
							5 + (mountainSize-1)*2
							1 + mountainSize
						]
						grid = [ new Array(size[0] + 3).join '#' ]
						for y in [0...size[1]]
							floor = '#'
							for x in [0...size[0]]
								if x - 1 > size[1] - y && size[0] - x > size[1] - y
									floor += '#'
								else
									floor += ' '
							grid.push floor + '#'
						grid.push grid[0]

						{
							grid: grid
							hamsterLocation: [ 2, size[1], 0 ]
							carryCorn: 0
						}
				}
				{
					name: "Task 4.6"
					generator: ->
						# schnecke
						firstPath = Math.floor(Math.random() * 5)
						line = []
						for i in [0...firstPath]
							line.push ' '
						line.push '1'
						spiral = [line]
						dir = 1
						prevlen = [firstPath + 2, 1]

						turns = Math.random()*10 + 3
						until turns <= 0 and dir == 3 # always end right
							len_after = Math.floor(Math.random() * 3) + 1
							len = prevlen[dir%2] + len_after
							switch dir
								when 0
									for i in [0...len_after]
										for line in spiral
											line.unshift '#'
									line = []
									for i in [0...len]
										line.push ' '
									spiral.unshift line
									break
								when 1
									linelen = spiral[0].length
									for i in [0...len_after]
										line = []
										for col in [0...linelen]
											line.push '#'
										spiral.push line
									for i in [0...len]
										spiral[i].unshift ' '
									break
								when 2
									for i in [0...len_after]
										for line in spiral
											line.push '#'
									line = []
									for i in [0...len]
										line.push ' '
									spiral.push line
									break
								when 3
									linelen = spiral[0].length
									for i in [0...len_after]
										line = []
										for col in [0...linelen]
											line.push '#'
										spiral.unshift line
									for i in [0...len]
										spiral[i].push ' '
									break

							prevlen[dir%2] = len + 1
							dir = (dir+1)%4
							turns--

						# frame
						for line in spiral
							line.push '#'
							line.unshift '#'
						cols = spiral[0].length
						line = []
						for i in [0...cols]
							line.push '#'
						spiral.push line
						spiral.unshift line

						for line, y in spiral
							spiral[y] = line.join ''
						{
							grid: spiral
							hamsterLocation: [ spiral[0].length - 2, spiral.length - 2, 180 ]
							carryCorn: 0
						}

				}
				{
					name: "Task 4.7"
					generator: ->
						mountainSize = Math.floor(Math.random() * 12) + 3
						size = [
							5 + (mountainSize-1)*2
							1 + mountainSize
						]
						grid = [ new Array(size[0] + 3).join '#' ]
						for y in [0...size[1]]
							floor = '#'
							for x in [0...size[0]]
								if x - 1 > size[1] - y && size[0] - x > size[1] - y
									floor += '1'
								else
									floor += ' '
							grid.push floor + '#'
						grid.push grid[0]

						{
							grid: grid
							hamsterLocation: [ 2, size[1], 0 ]
							carryCorn: 0
						}
				}
				{
					name: "Task 4.8"
					generator: ->
						# Labyrinth
						size = [
							Math.floor(Math.random() * 17) + 5
							Math.floor(Math.random() * 17) + 5
						]
						maze = []
						for y in [0...size[1]]
							line = []
							for x in [0...size[0]]
								line.push '#'
							maze.push line
						start = [ Math.floor(Math.random() * (size[0]-2))+1, Math.floor(Math.random() * (size[1]-2))+1, -> true ]

						stack = []
						current = start

						left = (x, y) ->
							maze[y][x - 1] == '#' && maze[y][x - 2] == '#' &&
							maze[y - 1][x - 1] == '#' && maze[y + 1][x - 1] == '#' &&
							maze[y - 1][x - 2] == '#' && maze[y + 1][x - 2] == '#'
						right = (x, y) ->
							maze[y][x + 1] == '#' && maze[y][x + 2] == '#' &&
							maze[y - 1][x + 1] == '#' && maze[y + 1][x + 1] == '#' &&
							maze[y - 1][x + 2] == '#' && maze[y + 1][x + 2] == '#'
						top = (x, y) ->
							maze[y - 1][x] == '#' && maze[y - 2][x] == '#' &&
							maze[y - 1][x - 1] == '#' && maze[y - 1][x + 1] == '#' &&
							maze[y - 2][x - 1] == '#' && maze[y - 2][x + 1] == '#'
						bottom = (x, y) ->
							maze[y + 1][x] == '#' && maze[y + 2][x] == '#' &&
							maze[y + 1][x - 1] == '#' && maze[y + 1][x + 1] == '#' &&
							maze[y + 2][x - 1] == '#' && maze[y + 2][x + 1] == '#'
						loop
							maze[current[1]][current[0]] = ' '
							neighbors = []
							# left
							if current[0] > 1 && current[1] > 0 && current[1] < size[1]-1 && left(current[0], current[1])
								neighbors.push [current[0] - 1, current[1], left.bind(this, current[0], current[1])]
							# right
							if current[0] < size[0] - 2 && current[1] > 0 && current[1] < size[1]-1 && right(current[0], current[1])
								neighbors.push [current[0] + 1, current[1], right.bind(this, current[0], current[1])]
							# top
							if current[1] > 1 && current[0] > 0 && current[0] < size[0]-1 && top(current[0], current[1])
									neighbors.push [current[0], current[1] - 1, top.bind(this, current[0], current[1])]
							# bottom
							if current[1] < size[1] - 2 && current[0] > 0 && current[0] < size[0]-1 && bottom(current[0], current[1])
								neighbors.push [current[0], current[1] + 1, bottom.bind(this, current[0], current[1])]
							if neighbors.length == 0
								current = null
								while not current and stack.length > 0
									current = stack.pop()
									if not current[2]()
										current = null
								if not current
									break
							else
								pick = Math.floor(Math.random() * neighbors.length)
								for neighbor, i in neighbors when i != pick
									stack.push neighbor
								current = neighbors[pick]
						loop
							location = [Math.floor(Math.random() * (size[0]-2))+1, Math.floor(Math.random() * (size[1]-2))+1]
							if maze[location[1]][location[0]] == ' '
								maze[location[1]][location[0]] = '1'
								break
						
						for line, y in maze
							maze[y] = line.join ''
						{
							grid: maze
							hamsterLocation: [ start[0], start[1], Math.floor(Math.random() * 4) * 90 ]
							carryCorn: 0
						}
				}
			]

	renderTemplate: (controller, model) ->
		@_super(controller, model)
		editor = @container.lookup 'controller:editor'
		editor.set 'model', model
		editor.setup()
		@render 'editor',
			outlet: 'editor'
			into: 'index'
			controller: editor
		consoleC = @container.lookup 'controller:console'
		consoleC.set 'model', model
		consoleC.setup()
		@render 'console',
			outlet: 'console'
			into: 'index'
			controller: consoleC
		playfield = @container.lookup 'controller:playfield'
		playfield.set 'model', model
		playfield.setup()
		@render 'playfield',
			outlet: 'playfield'
			into: 'index'
			controller: playfield


`export default IndexRoute`
