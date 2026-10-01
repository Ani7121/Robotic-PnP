# TASK-002 — Requirements-only design brief

Source: `docs/tasks/Task-002`; mission, requirements and resource constraints supplied in `PROJECT_STATE.md`. Architecture descriptions, prior decisions and prior reviews are deliberately excluded.

## Objective

Independently propose a feasible system for the required operation. Consider alternatives, edge cases and verification. Do not consult the existing proposed architecture or TASK-001 reviews during independent design.

## Mission and workpieces

- Automatically and repeatably pick horizontally presented Bi₂Te₃ sticks and insert them vertically into array-holder channels without functional damage.
- Nominal stick: 500–510 µm square cross-section, approximately 12 mm long.
- Nominal channel: approximately 530 µm square. Actual depth, taper, pitch, dimensional variation and insertion seating criterion are not supplied.
- Visible surface cracks are unacceptable; no damage-safe force or experimentally measured insertion tolerance is supplied.

## High-level requirements

- REQ-SYS-001: Automatic repeatable insertion.
- REQ-SYS-002: Target ≤60 s pick-to-place per stick.
- REQ-SYS-003: Footprint ≤3 ft × 6 ft.
- REQ-SYS-004: No functional damage; stated target <1 visibly damaged stick per 10 placements. Clarification of inspection and acceptance is required.
- REQ-SYS-005: Address modifications for sticks up to 1 × 1 × 20 mm.
- REQ-SYS-006: Multiple/swappable holders. Automatic holder exchange is not explicitly required.
- REQ-SYS-007: Alignment accuracy TBD experimentally. 5 µm is a provisional engineering target, not a customer requirement.

## Resources and constraints

- Hardware budget: $1,500 total; remaining funds/spend not itemized.
- Completion: approximately December 2026; exact deadline unspecified.
- Available UR3e. Sandia may provide LumenPnP; potential depth camera availability is unconfirmed.
- Representative Bi₂Te₃ parts and non-sensitive holders to be supplied by Sandia.
- Tin density-matching and graphite tribological surrogates to be supplied; neither establishes actual-part damage limits.
- UT machining, CAD, conventional/resin 3D printing; calipers listed, micron-level optical/force metrology not confirmed.
- One human Chief Engineer performs physical execution.
- Horizontal part presentation is required; regular spacing and upstream sorting responsibility are not established requirements.

## Reporting

Provide short independent findings with source links and evidence labels. Then exchange engineering critiques directly with the other participating specialists and preserve the actual messages. Final decision sheet: status/context; direct answer; short supported basis, risks and next steps, with a simple visual. No design decision is ACCEPTED.
