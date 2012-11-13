EmberDeviseExample.UserSessionNewView = EF.Form.extend
  templateName: 'userSessionNew'
  save: (data) ->
    EmberDeviseExample.get('router').get('userSessionNewController').signIn(data.email, data.password)
