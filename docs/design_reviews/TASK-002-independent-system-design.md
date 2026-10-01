# TASK-002 — Independent System Design

[Plain-language Chief Engineer reference](TASK-002-chief-engineer-reference.md) · [Review index](README.md)

## 1. Status and context

**PROPOSED · 1 October 2026 · No demonstrated insertion performance**

**Request:** Design from the high-level requirements, excluding the existing solution; evaluate feasibility and edge cases.

**Constraints:** Horizontal Bi₂Te₃ sticks, 500–510 µm square × ~12 mm, inserted vertically into ~530 µm square channels. Existing UR3e; $1,500 hardware budget; approximately December 2026 completion. Targets: ≤60 s/stick, ≤3 ft × 6 ft, no functional damage, swappable holders, modifications for 1 × 1 × 20 mm sticks.

Trace: [Task 2](../tasks/Task-002), [requirements-only brief: REQ-SYS-001–007](../tasks/TASK-002-requirements-only.md). Five fresh role assessments used this brief, excluding previous designs.

## 2. Answer

**Build a fixture-centered assembly cell: the robot handles transport; a supported tool and indexed holder handle insertion.** ENGINEERING JUDGMENT: recommended prototype; feasibility requires testing.

- **Pickup:** Test a broad side-contact vacuum saddle against soft mechanical jaws. Retain the original grip through horizontal-to-vertical rotation where possible.
- **Insertion head:** Support the tool at a fixed station. Keep the actual stick visible; verify position and shaft tilt after rotation/support.
- **Holder:** Index a swappable holder beneath the head on local XY motion. Set or correct angular alignment according to measured insertion tolerances.
- **Insertion:** Use a short Z carriage with experimentally established contact limits. Verify seating and intact release independently of force feedback.

```text
Horizontal tray → UR3e pick + turn → Supported insertion head
                                             ↓
                            Indexed holder + local optical check
                                             ↓
                              Slow Z insert → release → inspect
```

One sequencer controls pickup, imaging, holder motion and insertion. Register each holder after replacement. Missing part, uncertain pose, occupied channel or unexpected contact → stop and inspect; no blind force search.

**Competing approach:** A supported turnover cartridge could establish stick orientation mechanically and reduce active alignment. Test it against retained-grip insertion; added transfer, guide contact and removal may increase damage. Neither has proved superior.

## 3. Supporting facts, feasibility and next work

- **CALCULATION:** Largest nominal stick leaves only **10 µm per side**. At an assumed 12 mm engagement, an entrance-centered straight stick reaches that margin at approximately **0.048° tilt**. Actual depth and tolerances are unknown. [Calculation C1](TASK-002-evidence.md#c1-clearance-and-orientation)
- **SOURCE-BASED FACT:** UR3e specifies **±30 µm repeatability** and **3.5 N force-sensor accuracy**. These do not demonstrate the required insertion accuracy or damage protection. [UR specifications](https://www.universal-robots.com/manuals/EN/HTML/SW10_11/Content/prod-usr-man/complianceUR3e/H_g5_sections/appendix_g5/tech_spec_data.htm)
- **SOURCE-BASED FACT:** Published Bi₂Te₃ tests show orientation-dependent fracture strength. Their specimens do not establish safe forces for these sticks. [Wereszczak et al., 2010](https://impact.ornl.gov/en/publications/strength-of-bismuth-telluride/)

**Feasibility — ENGINEERING JUDGMENT:** Technically plausible; **$1,500 and December remain unverified**. Reuse robot/computing and borrow precision metrology where available. Obtain a complete priced bill of materials before buying motion hardware. Manual tray replenishment and holder swapping are development assumptions; bulk sorting and automatic holder exchange are outside the initial prototype.

**Critical failures:** Corner chipping before axial-force detection; stick slip or bow; tool/guide collision with installed neighbors; false seating; stick pulled out during release; safe insertion speed incompatible with 60 s. Larger sticks require compatible larger channels and revised tooling/stroke.

**Next four tasks:**

1. Measure channel depth/geometry, stick straightness, insertion tolerance and real-part damage limits; define seating and functional inspection. REQ-SYS-004, 007.
2. Compare retained grip and turnover cartridge on the same worst-fit channel surrounded by installed sticks; measure alignment, damage and no-pullout release. REQ-SYS-001, 004.
3. Verify optical uncertainty, contact/stopping limits and required motion axes; confirm borrowed equipment and priced hardware fit the budget. REQ-SYS-003, 007.
4. Automate and time multi-channel trials, holder swaps and fault recovery; document larger-stick changes. REQ-SYS-001–006.

**Proposed milestones:** October—handling/insertion evidence; November—automatic station; December—real-part demonstration. [Evidence and edge cases](TASK-002-evidence.md) · [Recorded discussion](TASK-002-team-discussion.md)
