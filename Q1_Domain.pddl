(define (domain assignment-q1-domain)
  (:requirements :typing :fluents :quantified-preconditions)
  
  (:types 
    robot location tool task - object
  )
  
  (:predicates
    (at ?r - robot ?l - location)
    (connected ?l1 - location ?l2 - location)
    (tool-at ?t - tool ?l - location)
    (carrying ?r - robot ?t - tool)
    (mounted ?r - robot ?t - tool)
    (task-at ?tsk - task ?l - location)
    (task-requires ?tsk - task ?t - tool)
    (task-done ?tsk - task)
    (is-storage ?l - location)
  )

  (:functions
    (carried-amount ?r - robot)
    (max-capacity ?r - robot)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and 
      (at ?r ?from)
      (connected ?from ?to)
    )
    :effect (and 
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )

  (:action pickup-tool
    :parameters (?r - robot ?t - tool ?l - location)
    :precondition (and 
      (at ?r ?l)
      (tool-at ?t ?l)
      (is-storage ?l)
      (< (carried-amount ?r) (max-capacity ?r))
    )
    :effect (and 
      (not (tool-at ?t ?l))
      (carrying ?r ?t)
      (increase (carried-amount ?r) 1)
    )
  )

  (:action drop-tool
    :parameters (?r - robot ?t - tool ?l - location)
    :precondition (and 
      (at ?r ?l)
      (carrying ?r ?t)
      (is-storage ?l)
    )
    :effect (and 
      (not (carrying ?r ?t))
      (tool-at ?t ?l)
      (decrease (carried-amount ?r) 1)
    )
  )

  (:action mount-tool
    :parameters (?r - robot ?t - tool)
    :precondition (and 
      (carrying ?r ?t)
      (not (exists (?other - tool) (mounted ?r ?other)))
    )
    :effect (and 
      (not (carrying ?r ?t))
      (mounted ?r ?t)
      (decrease (carried-amount ?r) 1)
    )
  )

  (:action unmount-tool
    :parameters (?r - robot ?t - tool)
    :precondition (and 
      (mounted ?r ?t)
      (< (carried-amount ?r) (max-capacity ?r))
    )
    :effect (and 
      (not (mounted ?r ?t))
      (carrying ?r ?t)
      (increase (carried-amount ?r) 1)
    )
  )

  (:action perform-task
    :parameters (?r - robot ?tsk - task ?t - tool ?l - location)
    :precondition (and 
      (at ?r ?l)
      (task-at ?tsk ?l)
      (task-requires ?tsk ?t)
      (mounted ?r ?t)
      (not (task-done ?tsk))
    )
    :effect (and 
      (task-done ?tsk)
    )
  )
)