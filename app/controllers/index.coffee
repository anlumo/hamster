`import Ember from 'ember'`

IndexController = Ember.Controller.extend
	init: ->
		template = localStorage.getItem 'selectedTemplate'
		@set 'selectedTemplate', JSON.parse(template)

	scratchpadChanged: (->
		localStorage.setItem 'scratchpad', @get 'model.scratchpad'
	).observes 'model.scratchpad'

	selectedTemplate: null

	gridChanged: (->
		localStorage.setItem 'grid', @get('model.playfield.grid').join('\n')
	).observes 'model.playfield.grid'

	carryCornChanged: (->
		localStorage.setItem 'carryCorn', @get('model.playfield.carryCorn')
	).observes 'model.playfield.carryCorn'

	hamsterLocationChanged: (->
		localStorage.setItem 'hamsterLocation', @get('model.playfield.hamsterLocation').join(',')
	).observes 'model.playfield.hamsterLocation'

	saveDialogButtons: [
		Ember.Object.create
			title: 'Save'
			clicked: 'saveDocument'
			dismiss: 'modal'
			type: 'primary'
		Ember.Object.create
			title: 'Cancel'
			dismiss: 'modal'
	]

	actions:
		play: ->
			window.Hub.publish 'play'
		reset: ->
			@get('model').set 'playfield', Ember.Object.create Ember.copy @get('selectedTemplate'), true
			window.Hub.publish 'stop'
		stepIn: ->
			window.Hub.publish 'stepIn'
		stepOver: ->
			window.Hub.publish 'stepOver'
		rotate: ->
			window.Hub.publish 'hamsterTurnLeft'
		clearConsole: ->
			@get('model').set 'logLines', Ember.A()
		selectTemplate: (template) ->
			localStorage.setItem 'selectedTemplate', JSON.stringify(template)
			@set 'selectedTemplate', template
			@get('model').set 'playfield', Ember.Object.create Ember.copy template, true
		addCorn: ->
			@get('model.playfield').incrementProperty 'carryCorn'
		removeCorn: ->
			if @get('model.playfield.carryCorn') > 0
				@get('model.playfield').decrementProperty 'carryCorn'

		load: ->
			fileSelector = Ember.$ '<input type="file" accept="application/javascript">'
			fileSelector.on 'change', (evt) =>
				if evt.target.files.length == 1
					file = evt.target.files[0]
					reader = new FileReader()
					reader.onload = =>
						@get('model').set 'scratchpad', reader.result
						window.Hub.publish 'stop'
					reader.onerror = ->
						window.Hub.publish 'logHTML', '<span class="error">Failed loading document: <em>' + reader.error.message.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>") + '</em></span>'
					reader.readAsText(file)
			fileSelector.click()
		save: ->
			saveFilename = localStorage.getItem 'saveFilename'
			if not saveFilename
				saveFilename = 'scratchpad.js'

			@set 'saveFilename', saveFilename
			window.Bootstrap.ModalManager.show 'SaveDialog'
			Ember.run.next ->
				Ember.$('#saveFilename').focus()
			false
		saveDocumentAndDimiss: ->
			window.Bootstrap.ModalManager.hide 'SaveDialog'
			@send 'saveDocument'
			false
		saveDocument: ->
			saveFilename = @get 'saveFilename'
			if not saveFilename
				saveFilename = 'scratchpad.js'
			else if not /\.js$/.test(saveFilename)
				saveFilename += '.js'
			@set 'saveFilename', saveFilename

			localStorage.setItem 'saveFilename', saveFilename
			save = document.createElement 'a'
			save.setAttribute 'download', saveFilename
			blob = new Blob [@get('model.scratchpad')],
				type: 'application/javascript'
			save.href = URL.createObjectURL blob

			event = new MouseEvent 'click',
				view: window
				bubbles: true
				cancelable: false
			save.dispatchEvent event
			false

`export default IndexController`
