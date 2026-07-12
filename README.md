# Assignment D6-V2: Autonomous Orbital Maintenance Platform – Tool Management and Payload Transport

**Files to run:** `Q1/Q1_Domain.pddl` with either `Q1/Q1_TrivialTask.pddl` or
`Q1/Q1_ComplexTask.pddl`; `Q2/Q2_Domain.pddl` with any of `Q2/Q2_SimpleTask.pddl`,
`Q2/Q2_ComplexTask.pddl`, `Q2/Q2_DurationFeasible.pddl`, or
`Q2/Q2_DurationInfeasible.pddl`. Verified init/goal/plan for each pair is in
[`Plans/`](Plans).

A single free-climbing maintenance robot retrieves, carries, mounts, uses, and
returns tools across storage modules and worksites. Carrying a tool and having it
mounted (usable) are modelled separately, and carrying capacity is limited.

## Q1 — Basic PDDL Model

`Q1_Domain.pddl` defines types `robot`, `location`, `tool`, `tool-slot`, and
`task`. A tool must be picked up into a free `tool-slot`
(`pick-up`), then mounted into the robot's single mount slot before it can be used
(`mount-tool`, `use-tool`), and can be unmounted or returned to storage
(`unmount-tool`, `return-tool`). `slot-free`/`tool-slot` objects model carrying
capacity: the number of `tool-slot` objects declared in a problem is the robot's
carrying limit.

- **`Q1_TrivialTask.pddl`** — one tool, one worksite, one task. Baseline sanity
  check of the action model.
- **`Q1_ComplexTask.pddl`** — three tools (wrench, drill, camera) and two
  worksites, but only two `tool-slot`s for three tools. The robot cannot carry
  everything at once, so a valid plan must return one tool mid-route to free a
  slot before fetching the last one — carrying capacity directly shapes the plan.

## Q2 — PDDL+ Model

`Q2_Domain.pddl` extends Q1's domain with continuous dynamics. `use-tool` is
replaced by a `start-use-tool` / `stop-use-tool` pair, and three numeric fluents
are added per tool: `wear`, `temperature`, `usage-duration`. While a tool is
in use, the `wear-and-heat` process increases all three continuously; while idle,
the `cool-down` process brings `temperature` back down. The `tool-overheats` event
fires if `temperature` reaches 100, marking the tool `broken` — there is no repair
action, so a broken tool is permanently unusable. `stop-use-tool` also requires at
least 5 time units of active use (a task can't be completed instantly), and
`start-use-tool` refuses to run a tool hotter than 80°, so a tool that hasn't
cooled from its last use can't be restarted immediately.

- **`Q2_SimpleTask.pddl`** — one tool, one task, cold start; confirms the
  process/event mechanics work without triggering any of them.
- **`Q2_ComplexTask.pddl`** — the same multi-tool, multi-worksite, limited-capacity
  shape as `Q1_ComplexTask.pddl`, now with every tool use taking real time and
  generating heat.
- **`Q2_DurationFeasible.pddl`** — the tool starts already warm (70°). It can
  start immediately, but the first use pushes it above the 80° restart threshold,
  so the plan must let time pass for it to cool before the second task can begin —
  duration and ordering directly determine feasibility.
- **`Q2_DurationInfeasible.pddl`** — the tool starts already `broken`. Since it can
  never be started and there is no repair action, the goal is unreachable; ENHSP
  reports the problem as unsolvable during preprocessing.
