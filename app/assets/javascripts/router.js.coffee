# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource 'mapnotes', path: '/', ->
    @resource 'mapnote', { path: '/:mapnote_id' }
