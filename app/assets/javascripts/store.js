EmberDeviseExample.store = DS.Store.create({
  revision: 11,
  adapter: DS.RESTAdapter.create({namespace: 'api/v1'})
});

