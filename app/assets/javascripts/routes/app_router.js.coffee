EmberDeviseExample.Router.map (match) ->
  match('/signIn').to('userSessionNew')
  match('/users/:user_id').to('user')
