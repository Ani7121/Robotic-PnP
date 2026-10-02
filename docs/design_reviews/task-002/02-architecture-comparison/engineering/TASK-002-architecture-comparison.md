# TASK-002 — Coarse/fine architecture comparison

## 1. Status and context

**PROPOSED · 2 October 2026 · Comparison, not a new architecture acceptance.**

**Question:** How does Task 002 compare with the earlier coarse positioning + fine alignment idea?

Baseline: [original workflow](../../../../../PROJECT_STATE.md#current-accepted-architecture), [Task 001 review](../../../task-001/engineering/TASK-001-system-architecture-process-flow.md). Candidate: [Task 002](../../01-system-design/engineering/TASK-002-independent-system-design.md). This requested follow-up permits comparing the previously excluded design; the original independent assessment remains unchanged. No new measurements were made.

## 2. Answer

**Task 002 is a different implementation of your coarse/fine idea. It does not replace that principle.** Both use the UR3e for handling and a separate precision mechanism for final alignment. The decision is where to put that mechanism and how to measure the actual stick after handling.

Conceptual diagrams; neither defines selected hardware:

```text
Earlier:  UR3e → carried fine stage + stick
                                ↓
                         stationary holder

Task 002: UR3e → supported insertion head + stick
                                ↓ local Z
                         holder on local XY stage
```

| Issue | Earlier carried-stage concept | Task 002 fixed-station concept |
|---|---|---|
| Precision support | Fine stage rides on the arm; arm/tool motion remains part of the relative error | Station supports tool; benefit depends on a stable coupling and local structure |
| Alignment measurement | Bottom-view stick measurement + top-view tool/holder registration; reconstruct relative pose | Measure actual stick/channel relationship after rotation and support; local geometry may shorten the measurement chain |
| Main new burden | Moving optics references, tool mass, cables and limited fine-stage travel | Docking/support shift, yielding or released arm connection, holder indexing travel |
| Filled-array access | Tool must clear installed sticks | Head, dock and moving populated holder must all clear installed sticks |
| Angular alignment | XY/XYZ alone cannot correct shaft tilt | XY holder alone cannot correct shaft tilt either |
| Cost and cycle | No complete priced or timed implementation | No complete priced or timed implementation; support acquisition may add operations |

**ENGINEERING JUDGMENT:** Keep coarse/fine separation. Test station-supported insertion first as a characterization setup; do not commit to automated docking or a full-array precision holder stage yet. Preserve the carried stage as a credible alternative. A supported XY tool over a fixed holder is a third layout if moving the populated holder becomes costly or obstructed.

## 3. Short basis and next decision

**CALCULATION:** Nominal side clearance is `(530−510)/2 = 10 µm`. At an assumed 12 mm engagement, ideal entrance-centered tilt reaches that margin at about **0.048°**; an adverse 5 µm offset halves the angle. Actual depth, bow, yaw and measurement uncertainty change the allowance. [Geometry and assumptions](../../01-system-design/engineering/TASK-002-evidence.md#c1-clearance-and-orientation), REQ-SYS-004/007.

**SOURCE-BASED FACT:** UR3e specifies ±30 µm pose repeatability and 3.5 N force accuracy. These do not establish relative insertion accuracy or a damage-safe stopping threshold. [Manufacturer specification](https://www.universal-robots.com/manuals/EN/HTML/SW10_11/Content/prod-usr-man/complianceUR3e/H_g5_sections/appendix_g5/tech_spec_data.htm), checked 2 October 2026.

**ENGINEERING JUDGMENT:** Task 002 proposes local support and makes post-support alignment verification and controlled insertion/release more explicit; these controls can also be used with the carried stage. Its weak point is the unresolved arm-to-carriage connection. Rigidly holding a docked tool while commanding local Z can make the robot oppose the carriage. The original design can also use local visual feedback; fewer transforms are a possible station benefit, not guaranteed accuracy.

**Smallest discriminating test:** Use the same grip, holder and stick geometry. First map safe XY/angle/depth limits with borrowed/manual metrology. Then compare arm-supported and station-supported configurations through rotation, support, insertion and release, including adjacent filled channels. Measure actual stick-to-channel offset/tilt, grip shift, peak contact, end-to-end stopping motion, seating, pullout and cycle time. Revalidate a stored pickup pose after rotation if slip or bow can change it. Use surrogates for setup; real Bi₂Te₃ is required to establish damage behavior. A manual support test screens the idea; it does not validate an automated dock.

Choose the layout only after it meets the measured alignment/damage envelope, clears populated channels, and has a priced implementation within **$1,500** and a demonstrated path to **≤60 s/stick**. No numerical safe force or universal optical tolerance is established. [Requirements](../../../../tasks/TASK-002-requirements-only.md), [contact/time checks](../../01-system-design/engineering/TASK-002-evidence.md#c2-contact-and-cycle-time-limits).

**Confidence:** High that both share the same principle; low that either physical layout is superior. Retaining the grip avoids transfers; mechanically constraining the shaft may reduce tilt but adds contact and release risks. Test that fork separately rather than attributing it to stage location.

[Plain-language comparison](../TASK-002-comparison-reference.md) · [Specialist assessments and actual discussion](../records/TASK-002-comparison-discussion.md)
