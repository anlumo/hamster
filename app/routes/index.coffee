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
		return Ember.Object.create
			scratchpad: scratchpad
			logLines: logLines
			runSpeed: runSpeed
			playfield: Ember.Object.create
				grid: grid
				hamsterLocation: hamsterLocation
				carryCorn: carryCorn
			playfieldTemplates: [
				{
					name: "Task 1"
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
					name: "Task 2"
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
					name: "Task 3"
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
					name: "Task 4"
					grid: [
						"########"
						"# 111  #"
						"# ###  #"
						"# 111  #"
						"#      #"
						"########"
					]
					hamsterLocation: [1, 2, 90]
					carryCorn: 0
				}
				{
					name: "Task 5"
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
					name: "Task 6"
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
					name: "Task 7"
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
					name: "Task 8"
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
					name: "Task 9"
					grid: [
						"#####################"
						"# 111111111111111111#"
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
					name: "Task 10"
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
					name: "Task 11"
					grid: [
						"##########"
						"#        #"
						"##########"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 0
				}
				{
					name: "Task 12"
					grid: [
						"##########"
						"#   1 1  #"
						"##########"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 8
				}
				{
					name: "Task 13"
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
					name: "Task 14"
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
					name: "Task 15"
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
					name: "Empty 20x5"
					grid: [
						"####################"
						"#                  #"
						"#                  #"
						"#                  #"
						"#                  #"
						"#                  #"
						"####################"
					]
					hamsterLocation: [1, 1, 0]
					carryCorn: 100
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


`export default IndexRoute`
