#= require application
#= require_tree ./support

Konacha.mochaOptions.ignoreLeaks = true

signOut = ->
  window.server.respondWith([200, {'Content-Type': 'application/json'}, JSON.stringify({token: EmberDeviseExample.userSession.get('auth_token')})])
  EmberDeviseExample.userSession.signOut()
  window.server.respond()



beforeEach ->
  # get the container for the application
  window.container = $('#wrapper')

  # set up ajax mocking
  window.server = sinon.fakeServer.create();
  sinon.spy(jQuery, "ajax")


afterEach ->
  # reset application state.  Right not just signing out
  signOut()
    
  # reset the server to use a real server
  window.server.restore()
    
  # unspy
  jQuery.ajax.restore()
