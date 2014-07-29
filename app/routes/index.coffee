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
