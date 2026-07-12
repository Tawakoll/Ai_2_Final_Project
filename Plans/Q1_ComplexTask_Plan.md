# Q1_ComplexTask — Initial State, Goal, Plan

## Initial state

- `robot1` at `storageA`
- Locations connected: `storageA`-`worksite1`-`worksite2`-`storageB` (path, both directions)
- Tools: `wrench` and `drill` at `storageA`, `camera` at `storageB`
- Only **two** tool-slots (`slot1`, `slot2`) for three tools
- Tasks: `tighten-bolt` (needs `wrench`) and `drill-hole` (needs `drill`) at
  `worksite1`; `inspect-panel` (needs `camera`) at `worksite2`

## Goal

- `(and (task-done tighten-bolt) (task-done drill-hole) (task-done inspect-panel))`

## Plan (ENHSP)

```
0.0: (pick-up robot1 drill storageA slot2)
1.0: (move robot1 storageA worksite1)
2.0: (mount-tool robot1 drill slot2)
3.0: (use-tool robot1 drill drill-hole worksite1)
4.0: (unmount-tool robot1 drill slot1)
5.0: (move robot1 worksite1 worksite2)
6.0: (return-tool robot1 drill worksite2 slot1)
7.0: (move robot1 worksite2 worksite1)
8.0: (move robot1 worksite1 storageA)
9.0: (pick-up robot1 wrench storageA slot1)
10.0: (move robot1 storageA worksite1)
11.0: (move robot1 worksite1 worksite2)
12.0: (move robot1 worksite2 storageB)
13.0: (pick-up robot1 camera storageB slot2)
14.0: (move robot1 storageB worksite2)
15.0: (mount-tool robot1 camera slot2)
16.0: (use-tool robot1 camera inspect-panel worksite2)
17.0: (move robot1 worksite2 worksite1)
18.0: (unmount-tool robot1 camera slot2)
19.0: (mount-tool robot1 wrench slot1)
20.0: (use-tool robot1 wrench tighten-bolt worksite1)
```

Plan length: 21. Note the drill is dropped at `worksite2` (step 6) purely to free
a slot for the camera — a direct effect of the two-slot capacity limit.
