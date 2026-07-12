# Q1_TrivialTask — Initial State, Goal, Plan

## Initial state

- `robot1` at `storageA`
- `storageA` <-> `worksite1` connected
- `wrench` at `storageA`
- `slot1` free, `robot1`'s mount slot free
- Task `tighten-bolt` at `worksite1`, requires `wrench`

## Goal

- `(task-done tighten-bolt)`

## Plan (ENHSP)

```
0.0: (pick-up robot1 wrench storageA slot1)
1.0: (move robot1 storageA worksite1)
2.0: (mount-tool robot1 wrench slot1)
3.0: (use-tool robot1 wrench tighten-bolt worksite1)
```

Plan length: 4
