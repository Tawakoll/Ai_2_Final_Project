; Demonstrates that a problem instance can be genuinely infeasible: the
; drill starts already broken (e.g. it overheated and failed during
; earlier use, before this planning episode even begins). start-use-tool
; requires (not (broken ?t)), and this domain has no repair action, so
; the drill can never be started again. drill-hole therefore can never
; become task-done, regardless of how the available actions are ordered.
(define (problem tools-plus-duration-infeasible)
  (:domain tool-management-plus)

  (:objects
    robot1 - robot
    storageA - location
    worksite1 - location
    slot1 - tool-slot
    drill - tool
    drill-hole - task
  )

  (:init
    (robot-at robot1 storageA)
    (connected storageA worksite1)
    (connected worksite1 storageA)
    (tool-at drill storageA)
    (slot-free slot1)
    (mount-slot-free robot1)
    (task-at drill-hole worksite1)
    (requires-tool drill-hole drill)
    (broken drill)

    (= (wear drill) 0)
    (= (temperature drill) 0)
    (= (usage-duration drill) 0)
  )

  (:goal
    (task-done drill-hole)
  )
)
