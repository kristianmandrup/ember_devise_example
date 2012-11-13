#= require spec_helper 
describe "EmberDeviseExample.userSessionNew", ->

  goToSignIn = ->
    Ember.run ->
      EmberDeviseExample.get('router').transitionTo('signIn')
    
  it "should show sign in page", ->
    goToSignIn()
        
    inputs = window.container.find('input')
    button = window.container.find('button')

    inputs.length.should.equal(2)
    button.length.should.equal(1)


  it "should log in", ->
    goToSignIn()
    
    inputs = window.container.find('input')
    button = window.container.find('button') 
    
    # fill in dummy email & password
    inputs[0].value = 'validuser@example.com'
    inputs[1].value = 'validpassword' 

    EmberDeviseExample.userSession.get('signedIn').should.be.false
    
    # click the button.  We should now be signed in     
    window.server.respondWith([200, {'Content-Type': 'application/json'}, JSON.stringify({token: 'somerandomstring'})])
    button.click()
    window.server.respond()
    EmberDeviseExample.userSession.get('signedIn').should.be.true