`import Ember from 'ember'`

Router = Ember.Router.extend
  location: HamsterENV.locationType

Router.map ->

  @route 'help'

`export default Router`
