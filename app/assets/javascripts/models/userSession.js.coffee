EmberDeviseExample.UserSession = Ember.Object.extend
   auth_token : null,
   urlBase : '/api/v1/tokens',
   errorMsg : null,

   signedIn : (-> 
      return (this.get('auth_token') != null)
   ).property('auth_token')

   signIn : (email, password) ->
      $.ajax 
         url : "#{this.get('urlBase')}.json"
         context : EmberDeviseExample.userSession
         type : 'POST'
         data : 
            email : email
            password : password

         success : (data) ->
            this.set('auth_token', data.token)

         error : (data) ->
            this.errorMsg = "there was an error"
         

      return this.get('auth_token')
   
   signOut : ->
      $.ajax
         url : "#{this.get('urlBase')}/#{this.get('auth_token')}.json"
         context : EmberDeviseExample.userSession
         type : 'DELETE'
         success : (data) ->
            this.set('auth_token', null)
         
         error : (data) -> 
           this.errorMsg = "there was an error"
      return null

EmberDeviseExample.userSession = EmberDeviseExample.UserSession.create()