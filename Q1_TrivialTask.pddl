(define (problem assignment-q1-simple)
  (:domain assignment-q1-domain)
  
  (:objects
    robby - robot
    storage worksite - location
    wrench - tool
    tighten-bolt - task
  )

  (:init
    (at robby storage)
    (connected storage worksite)
    (connected worksite storage)
    (is-storage storage)
    
    (tool-at wrench storage)
    
    (task-at tighten-bolt worksite)
    (task-requires tighten-bolt wrench)
    
    (= (carried-amount robby) 0)
    (= (max-capacity robby) 2)
  )

  (:goal 
    (forall (?tsk - task) (task-done ?tsk))
  )
)