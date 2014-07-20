`import Ember from 'ember'`

Router = Ember.Router.extend
  location: HamsterENV.locationType

Router.map ->

  @route 'about'

`export default Router`
