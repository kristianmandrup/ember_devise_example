EmberDeviseExample.Score = DS.Model.extend
  id:         DS.attr('number')
  score:      DS.attr('string')
  workout_id: DS.attr('number')
  comments:   DS.attr('string')
  