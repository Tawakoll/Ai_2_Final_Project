(define (problem tools-plus-simple)
  (:domain tool-management-plus)

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

    (= (wear wrench) 0)
    (= (temperature wrench) 0)
    (= (usage-duration wrench) 0)

    (= (battery-level robot1) 100)
  )

  (:goal
    (task-done tighten-bolt)
  )
)
