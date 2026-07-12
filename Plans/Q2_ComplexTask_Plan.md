# Q2_ComplexTask — Initial State, Goal, Plan

## Initial state

Same layout as `Q1_ComplexTask` (one robot, tools `wrench`/`drill` at `storageA`,
`camera` at `storageB`, two tool-slots, three tasks across `worksite1`/`worksite2`),
with every tool starting cold (`wear`=0, `temperature`=0, `usage-duration`=0).

## Goal

- `(and (task-done tighten-bolt) (task-done drill-hole) (task-done inspect-panel))`

## Plan (ENHSP)

```
0: (pick-up robot1 drill storageA slot2)
0: (pick-up robot1 wrench storageA slot1)
0: (move robot1 storageA worksite1)
0: (move robot1 worksite1 worksite2)
0: (mount-tool robot1 drill slot2)
0: (move robot1 worksite2 storageB)
0: (pick-up robot1 camera storageB slot2)
0: (move robot1 storageB worksite2)
0: (move robot1 worksite2 worksite1)
0: (return-tool robot1 camera worksite1 slot2)
0: (start-use-tool robot1 drill drill-hole worksite1)
0: -----waiting---- [5.0]
5.0: (stop-use-tool robot1 drill drill-hole worksite1)
5.0: (unmount-tool robot1 drill slot2)
5.0: (mount-tool robot1 wrench slot1)
5.0: (pick-up robot1 camera worksite1 slot1)
5.0: (move robot1 worksite1 worksite2)
5.0: (return-tool robot1 drill worksite2 slot2)
5.0: -----waiting---- [8.0]
8.0: (move robot1 worksite2 worksite1)
8.0: (start-use-tool robot1 wrench tighten-bolt worksite1)
8.0: -----waiting---- [13.0]
13.0: (stop-use-tool robot1 wrench tighten-bolt worksite1)
13.0: (move robot1 worksite1 worksite2)
13.0: (unmount-tool robot1 wrench slot2)
13.0: (mount-tool robot1 camera slot1)
13.0: (start-use-tool robot1 camera inspect-panel worksite2)
13.0: -----waiting---- [18.0]
18.0: (stop-use-tool robot1 camera inspect-panel worksite2)
```

Plan length: 43, total elapsed time 18.0. Combines the Q1 capacity-driven tool
juggling with mandatory per-use wait times.
