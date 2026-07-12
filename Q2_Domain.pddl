(define (domain tool-management-plus)
  (:requirements :strips :typing :fluents :time :negative-preconditions)

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
    (in-use ?t - tool)
    (broken ?t - tool)
    (in-use-for ?t - tool ?k - task)
  )

  (:functions
    (wear ?t - tool)
    (temperature ?t - tool)
    (usage-duration ?t - tool)
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
      (not (in-use ?t))
    )
    :effect (and
      (not (mounted ?r ?t))
      (mount-slot-free ?r)
      (carrying ?r ?t)
      (tool-in-slot ?t ?s)
      (not (slot-free ?s))
    )
  )

  ; Using a tool is split into start/stop so that wear and temperature can
  ; accumulate continuously (via the wear-and-heat process) for as long as
  ; the tool is actually active, instead of changing state instantaneously.
  ; in-use-for binds the running session to the specific task that opened
  ; it, so a session started for one task cannot be closed out early to
  ; complete a different task that merely shares the same tool.
  (:action start-use-tool
    :parameters (?r - robot ?t - tool ?k - task ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (task-at ?k ?l)
      (requires-tool ?k ?t)
      (mounted ?r ?t)
      (not (in-use ?t))
      (not (broken ?t))
      (<= (temperature ?t) 80)
    )
    :effect (and
      (in-use ?t)
      (in-use-for ?t ?k)
      (assign (usage-duration ?t) 0)
    )
  )

  ; A task only counts as done once the tool has been actively running for
  ; at least 5 time units, so a task cannot be "instant-completed" for free.
  (:action stop-use-tool
    :parameters (?r - robot ?t - tool ?k - task ?l - location)
    :precondition (and
      (robot-at ?r ?l)
      (task-at ?k ?l)
      (requires-tool ?k ?t)
      (mounted ?r ?t)
      (in-use ?t)
      (in-use-for ?t ?k)
      (not (broken ?t))
      (>= (usage-duration ?t) 5)
    )
    :effect (and
      (not (in-use ?t))
      (not (in-use-for ?t ?k))
      (task-done ?k)
    )
  )

  (:process wear-and-heat
    :parameters (?t - tool)
    :precondition (and
      (in-use ?t)
      (not (broken ?t))
    )
    :effect (and
      (increase (wear ?t) (* #t 1))
      (increase (temperature ?t) (* #t 5))
      (increase (usage-duration ?t) (* #t 1))
    )
  )

  (:process cool-down
    :parameters (?t - tool)
    :precondition (and
      (not (in-use ?t))
      (not (broken ?t))
      (> (temperature ?t) 0)
    )
    :effect (decrease (temperature ?t) (* #t 2))
  )

  ; If a tool is left running (or reused before it has cooled), its
  ; temperature can cross the failure threshold. Once broken, the tool can
  ; no longer be started, so any task still depending on it becomes
  ; unreachable -- this is the model's "poor ordering causes infeasibility"
  ; mechanism.
  (:event tool-overheats
    :parameters (?t - tool)
    :precondition (and
      (>= (temperature ?t) 100)
      (not (broken ?t))
    )
    :effect (and
      (broken ?t)
      (not (in-use ?t))
    )
  )
)
