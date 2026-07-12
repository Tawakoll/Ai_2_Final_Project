# Q2_DurationInfeasible — Initial State, Goal, Plan

## Initial state

- `robot1` at `storageA`; `storageA` <-> `worksite1` connected
- `drill` at `storageA`, already `broken`, cold otherwise (`wear`=0,
  `temperature`=0, `usage-duration`=0)
- Task `drill-hole` at `worksite1`, requires `drill`

## Goal

- `(task-done drill-hole)`

## Plan (ENHSP)

```
Aibr Preprocessing
Problem Detected as Unsolvable by AIBR during preprocessing
Unsolvable Problem
```

No plan exists: `start-use-tool` requires `(not (broken ?t))`, and the domain has
no repair action, so a `broken` tool can never be started again. ENHSP confirms
this analytically during preprocessing (< 1 second) rather than exhausting a
search.
