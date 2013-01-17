EmberDeviseExample.Score = DS.Model.extend
  'when':       DS.attr('string')
  what:         DS.attr('string')
  user:         DS.belongsTo('EmberDeviseExample.User')

