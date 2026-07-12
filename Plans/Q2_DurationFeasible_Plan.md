# Q2_DurationFeasible — Initial State, Goal, Plan

## Initial state

- `robot1` at `storageA`; path `storageA` <-> `worksite1` <-> `worksite2`
- `drill` at `storageA`, already warm: `temperature`=70, `wear`=0, `usage-duration`=0
- Two tasks needing the same `drill`: `drill-hole-1` at `worksite1`,
  `drill-hole-2` at `worksite2`

## Goal

- `(and (task-done drill-hole-1) (task-done drill-hole-2))`

## Plan (ENHSP)

```
0: (pick-up robot1 drill storageA slot1)
0: (move robot1 storageA worksite1)
0: (mount-tool robot1 drill slot1)
0: -----waiting---- [12.0]
12.0: (move robot1 worksite1 worksite2)
12.0: -----waiting---- [34.0]
34.0: (start-use-tool robot1 drill drill-hole-2 worksite2)
34.0: -----waiting---- [40.0]
40.0: (stop-use-tool robot1 drill drill-hole-2 worksite2)
40.0: (move robot1 worksite2 worksite1)
40.0: -----waiting---- [43.0]
43.0: (start-use-tool robot1 drill drill-hole-1 worksite1)
43.0: -----waiting---- [48.0]
48.0: (stop-use-tool robot1 drill drill-hole-1 worksite1)
```

Plan length: 57, total elapsed time 48.0. ENHSP's satisficing search finds waits
longer than the strict minimum, but the key point holds: it cannot start the
second use of the drill without first letting time pass for it to cool below 80°.
