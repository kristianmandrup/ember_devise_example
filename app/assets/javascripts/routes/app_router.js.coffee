EmberDeviseExample.Router = Ember.Router.extend
  location: 'hash'

  root: Ember.Route.extend
    index: Ember.Route.extend
      route: '/'

      # You'll likely want to connect a view here.
      # connectOutlets: function(router) {
      #   router.get('applicationController').connectOutlet(App.MainView);
      # }

      # Layout your routes here...

    signIn: Ember.Route.extend
      route: '/signIn'
      connectOutlets: (router) ->
        router.get('applicationController').connectOutlet('userSessionNew')
      
