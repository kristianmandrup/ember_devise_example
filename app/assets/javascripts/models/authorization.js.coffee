EmberDeviseExample.Authorization = Ember.Object.extend
  action: ''
  object: null
  response: 401
  urlBase: ApiUrl.authorizations_path
  
  can : (-> 
      return (this.get('response') == 200)
  ).property('response')
  
  authorize: ->
    # if object is an instance, include the id in the query params
    # otherwise, just include the class name
    cName = this.object.toString()
    id = null
    if Ember.typeOf(this.object) == "instance"
      # cname looks something like "<namespace.name:embernumber>"
      # turn it into "namespace.name"
      cName.replace(/\<\>/g, "")
      cName = cName.split(":")[0] 
      id = this.object.get("id")
    
    $.ajax 
       url : "#{this.get('urlBase')}.json"
       context : this
       type : 'GET'
       data : 
          cName : cName
          id : id

       complete : (data, textStatus, xhr) ->
          this.set('response', data.status)

    return this.get('can')
    
      
