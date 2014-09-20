App.NoteView = Ember.View.extend
  classNames: 'note'
  templateName: 'note'
  updateNote: (->
    Ember.run.scheduleOnce 'afterRender', this, 'initializeNote'
  ).observes('controller.model').on 'didInsertElement'

  keyUp: ->
    Ember.run.debounce this, 'compareText', 1000

  compareText: ->
    controller = @.get 'controller'
    uiText     = controller.get 'text'
    modelText  = controller.get 'model.text'

    if uiText != '' && uiText != modelText
      controller.saveMapnote()

  initializeNote: ->
    @.$().addClass 'init'
    @.$().addClass 'active'
    @.$('textarea').val ''
    @.$('textarea').focus()
    unless @.get 'controller.model.isNew'
      @.set('controller.text', @.get 'controller.model.text')

  displayNote: ->
    @.$().addClass 'active'
    @.$().transition
      x: 0

  hideNote: ->
    @.$().removeClass 'active'

    offset = @.$().width() + 20
    @.$().transition
      x: offset

  click: (evt)->
    if $(evt.target).is '.note-slider'
      if $(evt.target).hasClass 'right'
        @hideNote()
      else
        @displayNote()
