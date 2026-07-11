(define (problem tools-simple)
  (:domain tool-management)

  (:objects
    robot1 - robot
    storageA - location
    worksite1 - location
    slot1 - tool-slot
    wrench - tool
    tighten-bolt - task
  )

  (:init
    (robot-at robot1 storageA)
    (connected storageA worksite1)
    (connected worksite1 storageA)
    (tool-at wrench storageA)
    (slot-free slot1)
    (mount-slot-free robot1)
    (task-at tighten-bolt worksite1)
    (requires-tool tighten-bolt wrench)
  )
  

  (:goal
    (task-done tighten-bolt)
  )
)
