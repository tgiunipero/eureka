App.ConfigView = Ember.View.extend
  classNames: 'overlay'
  isVisible: Ember.computed.alias 'controller.active'
  classNameBindings: 'isVisible'

  fadeInMapSamples: (->
    Ember.run.scheduleOnce 'afterRender', this, '_fadeInMapSamples'
  ).on 'didInsertElement'

  _fadeInMapSamples: ->
    @.$('.lazy').lazyload(
      effect: 'fadeIn'
      effectspeed: 300
      event: 'load'
    ).trigger 'load'

  hideConfigOnEsc: (evt)->
    if evt.keyCode == 27
      @hideConfig evt

  hideConfig: (evt)->
    @.$().addClass 'fade-out'
    Ember.run.later this, ->
      @.set 'isVisible', false
      @.$().removeClass 'fade-out'
    , 300

  preventScroll: (->
    if @.get 'isVisible'
      window.scrollTo 0, 0
      $('body').css 'overflow', 'hidden'
    else
      $('body').css 'overflow', 'initial'
  ).observes 'isVisible'

  click: (evt)->
    if $(evt.target).is '.close, .overlay'
      @hideConfig evt

  didInsertElement: ->
    $(document).on 'keyup', @hideConfigOnEsc.bind(this)

  willDestroyElement: ->
    $(document).off 'keyup', @hideConfigOnEsc.bind(this)
