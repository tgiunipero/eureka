App.MapnoteController = Ember.ObjectController.extend
  text: ''
  latitude: ''
  longitute: ''

  saveMapnote: ->
    model = @.get 'model'
    model.set 'text', @text
    model.set 'latitude', @latitude
    model.set 'longitute', @longitute
    model.set 'updated', new Date()
    if model.get 'isNew'
      model.set 'created', new Date()
    model.save()