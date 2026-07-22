; Demonstrates that tool usage ordering/duration affects feasibility.
; The drill starts already warm (temperature 70, e.g. from prior use).
; It can still start the first task immediately (70 <= 80), but running
; it for the required 5 time units pushes the temperature to 95 -- too
; hot to safely start the second task right away (95 > 80). A correct
; plan must let the cool-down process run for a while between the two
; tasks before starting the second one. No wait is hard-coded here: the
; planner itself must discover that it needs to let time pass.
(define (problem tools-plus-duration-feasible)
  (:domain tool-management-plus)

  (:objects
    robot1 - robot
    storageA - location
    worksite1 worksite2 - location
    slot1 - tool-slot
    drill - tool
    drill-hole-1 drill-hole-2 - task
  )

  (:init
    (robot-at robot1 storageA)

    (connected storageA worksite1)
    (connected worksite1 storageA)
    (connected worksite1 worksite2)
    (connected worksite2 worksite1)

    (tool-at drill storageA)
    (slot-free slot1)
    (mount-slot-free robot1)

    (task-at drill-hole-1 worksite1)
    (task-at drill-hole-2 worksite2)
    (requires-tool drill-hole-1 drill)
    (requires-tool drill-hole-2 drill)

    (= (wear drill) 0)
    (= (temperature drill) 70)
    (= (usage-duration drill) 0)

    (= (battery-level robot1) 100)
  )

  (:goal
    (and
      (task-done drill-hole-1)
      (task-done drill-hole-2)
    )
  )
)
