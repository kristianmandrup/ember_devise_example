#= require spec_helper 
 describe "EmberDeviseExample.authorization", ->
   it "should deny access, prototype", ->
      # return status, no body
      window.server.respondWith [
        401 
        'Content-Type': 'application/json'
        ""  
      ]
     
      auth = EmberDeviseExample.Authorization.create()
      auth.setProperties
        action: 'someaction'
        object: EmberDeviseExample.Score
     
      auth.get("can").should.be.false
     
      auth.authorize()
      window.server.respond()
 
      auth.get("can").should.be.false


 
   it "should deny access, instance", ->
      # load a score
      score_fake_id = 15
      window.server.respondWith [
        200
        'Content-Type': 'application/json' 
        JSON.stringify
          score: 
            id: score_fake_id
            score: '195 lbs'
            workout_id: 3
            comments: 'That was hard!'
          
      ]
      score = EmberDeviseExample.store.find(EmberDeviseExample.Score, score_fake_id)
      window.server.respond()
      # /load score

      window.server.respondWith [
        401
        'Content-Type': 'application/json'
        ""
      ]
     
      auth = EmberDeviseExample.Authorization.create()
      auth.setProperties
        action: 'someaction'
        object: score
     
      auth.get("can").should.be.false
     
      auth.authorize()
      window.server.respond()
 
      auth.get("can").should.be.false




   it "should allow access, prototype", ->
      # return status, no body
      window.server.respondWith [
        200
        'Content-Type': 'application/json'
        ""  
      ]
      
      auth = EmberDeviseExample.Authorization.create()
      auth.setProperties
        action: 'someaction'
        object: EmberDeviseExample.Score
     
      auth.get("can").should.be.false
     
      auth.authorize()
      window.server.respond()
 
      auth.get("can").should.be.true





   it "should allow access, instance", ->
      # load a score
      score_fake_id = 15
      window.server.respondWith [
        200
        'Content-Type': 'application/json' 
        JSON.stringify
          id: score_fake_id
          score: '195 lbs'
          workout_id: 3
          comments: 'That was hard!'
      ]
      score = EmberDeviseExample.store.find(EmberDeviseExample.Score, score_fake_id)
      window.server.respond()
      # /load score

      # return status, no body      
      window.server.respondWith [
        200
        'Content-Type': 'application/json'
        ""  
      ]
       
      auth = EmberDeviseExample.Authorization.create()
      auth.setProperties
         action: 'someaction'
         object: score
      
      auth.get("can").should.be.false
     
      auth.authorize()
      window.server.respond()
 
      auth.get("can").should.be.true
 
        