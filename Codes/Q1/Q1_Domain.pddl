(define (domain tool-management)
  (:requirements :strips :typing)

  (:types
    robot location tool tool-slot task
  )

  (:predicates
    (robot-at ?r - robot ?l - location)
    (connected ?l1 - location ?l2 - location)
    (tool-at ?t - tool ?l - location)
    (carrying ?r - robot ?t - tool)
    (tool-in-slot ?t - tool ?s - tool-slot)
    (slot-free ?s - tool-slot)
    (mounted ?r - robot ?t - tool)
    (mount-slot-free ?r - robot)
    (task-at ?k - task ?l - location)
    (requires-tool ?k - task ?t - tool)
    (task-done ?k - task)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and
      (robot-at ?r ?from)
      (connected ?from ?to)
    )
    :effect (and
      (not (robot-at ?r ?from))
      (robot-at ?r ?to)
    )
  )

  (:action pick-up
    :parameters (?r - robot ?t - tool ?l - location ?s - tool-slot)
    :precondition (and
      (robot-at ?r ?l)
      (tool-at ?t ?l)
      (slot-free ?s)
    )
    :effect (and
      (not (tool-at ?t ?l))
      (not (slot-free ?s))
      (carrying ?r ?t)
      (tool-in-slot ?t ?s)
    )
  )

  (:action return-tool
    :parameters (?r - robot ?t - tool ?l - location ?s - tool-slot)
    :precondition (and
      (robot-at ?r ?l)
      (carrying ?r ?t)
      (tool-in-slot ?t ?s)
    )
    :effect (and
      (not (carrying ?r ?t))
      (not (tool-in-slot ?t ?s))
      (slot-free ?s)
      (tool-at ?t ?l)
    )
  )

  (:action mount-tool
    :parameters (?r - robot ?t - tool ?s - tool-slot)
    :precondition (and
      (carrying ?r ?t)
      (tool-in-slot ?t ?s)
      (mount-slot-free ?r)
    )
    :effect (and
      (not (carrying ?r ?t))
      (not (tool-in-slot ?t ?s))
      (slot-free ?s)
      (not (mount-slot-free ?r))
      (mounted ?r ?t)
    )
  )

  (:action unmount-tool
    :parameters (?r - robot ?t - tool ?s - tool-slot)
    :precondition (and
      (mounted ?r ?t)
      (slot-free ?s)
    )
    :effect (and
      (not (mounted ?r ?t))
      (mount-slot-free ?r)
      (carrying ?r ?t)
      (tool-in-slot ?t ?s)
      (not (slot-free ?s))
    )
  )

  (:action use-tool
    :parameters (?r - robot ?t - tool ?k - task ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (task-at ?k ?l)
      (requires-tool ?k ?t)
      (mounted ?r ?t)
    )
    :effect (and
      (task-done ?k)
    )
  )
)
