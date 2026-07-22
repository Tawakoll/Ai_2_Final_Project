(define (problem tools-plus-complex)
  (:domain tool-management-plus)

  (:objects
    robot1 - robot
    storageA storageB worksite1 worksite2 - location
    slot1 slot2 - tool-slot
    wrench drill camera - tool
    tighten-bolt drill-hole inspect-panel - task
  )

  (:init
    (robot-at robot1 storageA)

    (connected storageA worksite1)
    (connected worksite1 storageA)
    (connected worksite1 worksite2)
    (connected worksite2 worksite1)
    (connected worksite2 storageB)
    (connected storageB worksite2)

    (tool-at wrench storageA)
    (tool-at drill storageA)
    (tool-at camera storageB)

    (slot-free slot1)
    (slot-free slot2)

    (mount-slot-free robot1)

    (task-at tighten-bolt worksite1)
    (task-at drill-hole worksite1)
    (task-at inspect-panel worksite2)

    (requires-tool tighten-bolt wrench)
    (requires-tool drill-hole drill)
    (requires-tool inspect-panel camera)

    (= (wear wrench) 0)
    (= (temperature wrench) 0)
    (= (usage-duration wrench) 0)

    (= (wear drill) 0)
    (= (temperature drill) 0)
    (= (usage-duration drill) 0)

    (= (wear camera) 0)
    (= (temperature camera) 0)
    (= (usage-duration camera) 0)

    (= (battery-level robot1) 100)
  )

  (:goal
    (and
      (task-done tighten-bolt)
      (task-done drill-hole)
      (task-done inspect-panel)
    )
  )
)
