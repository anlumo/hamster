`import Ember from 'ember'`
`import Resolver from 'ember/resolver'`
`import loadInitializers from 'ember/load-initializers'`

Ember.MODEL_FACTORY_INJECTIONS = true

App = Ember.Application.extend
    modulePrefix: 'hamster' # TODO: loaded via config
    Resolver: Resolver

loadInitializers App, 'hamster'

`export default App`
