EmberDeviseExample.User = DS.Model.extend
  email:        DS.attr('string')
  scores:       DS.hasMany('EmberDeviseExample.Score')

EmberDeviseExample.store.adapter.serializer.map('EmberDeviseExample.User', {scores: {embedded: 'load'}})