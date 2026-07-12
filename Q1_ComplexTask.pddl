(define (problem tools-complex)
  (:domain tool-management)

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
  )

  (:goal
    (and
      (task-done tighten-bolt)
      (task-done drill-hole)
      (task-done inspect-panel)
    )
  )
)
