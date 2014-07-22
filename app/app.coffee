`import Ember from 'ember'`
`import Resolver from 'ember/resolver'`
`import loadInitializers from 'ember/load-initializers'`

Ember.MODEL_FACTORY_INJECTIONS = true

App = Ember.Application.extend
    modulePrefix: 'hamster' # TODO: loaded via config
    Resolver: Resolver

loadInitializers App, 'hamster'

window.Hub = Ember.Object.create
    init: ->
        @set 'HUB', Ember.Object.createWithMixins Ember.Evented, {}

    publish: ->
        hub = @get 'HUB'
        hub.trigger.apply hub, arguments
    subscribe: ->
        hub = @get 'HUB'
        hub.on.apply hub, arguments
    unsubscribe: ->
        hub = @get 'HUB'
        hub.off.apply hub, arguments

`export default App`
