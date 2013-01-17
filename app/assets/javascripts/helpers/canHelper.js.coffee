# based on http://livsey.org/blog/2012/10/16/writing-a-helper-to-check-permissions-in-ember-dot-js/
Ember.Handlebars.registerBoundHelper 'can', (object, options) ->

    permission = EmberDeviseExample.Authorization.create
        action: options.hash.action
        object: object

    permission.authorize()

    options.contexts = [permission]

    Ember.Handlebars.helpers.boundIf.call(permission, "can", options)


