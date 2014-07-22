`import Ember from 'ember'`

Router = Ember.Router.extend
  location: HamsterENV.locationType

Router.map ->

  @route 'about'
  @route 'help'

`export default Router`
