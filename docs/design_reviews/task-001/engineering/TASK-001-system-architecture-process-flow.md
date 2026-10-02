# TASK-001 — System Architecture & Process Flow

## 1. Status and context

**PROPOSED · 1 October 2026 · Architecture not selected**

**Request:** Are we solving this problem the right way? Define the architecture, process, goals, risks and next tasks.

**Project facts:** Horizontal Bi₂Te₃ sticks, 500–510 µm square × approximately 12 mm long, must enter approximately 530 µm square channels vertically. Available: UR3e and machine shops. Hardware budget: **$1,500**. Target completion: **December 2026**, exact date TBD.

**Required outcome:** Automatic insertion without functional damage; target ≤60 s/stick; ≤3 ft × 6 ft footprint; swappable holders; modification plan for sticks up to 1 × 1 × 20 mm. Alignment tolerance is unverified; **5 µm is a provisional target**.

Trace: [TASK-001](../../../tasks/Task-001.md), [PROJECT_STATE: REQ-SYS-001–007](../../../../PROJECT_STATE.md). These are project-reported dimensions and requirements, not new test results.

## 2. Answer

**Yes—the coarse/fine split is sound. The current hardware arrangement is not yet validated.** Use the UR3e for pickup, reorientation and coarse transport. Measure actual stick alignment near the channel; use controlled fine motion for insertion.

**Recommended comparison:** Test a fixed precision station against the current robot-carried fine stage. Start with the same grip retained throughout; moving the holder is an option. Select the simpler arrangement that meets measured insertion tolerances without damage. Neither candidate has demonstrated superiority.

```text
Horizontal sticks → UR3e: pick + rotate + transport
                                      ↓
                  Local measurement + fine alignment
                  [fixed station OR robot-carried stage]
                                      ↓
                      Controlled insertion → release → verify
```

Register each swapped holder. Measure the stick after rotation and any docking/support. Failed pickup → bounded retry; uncertain alignment → stop/reimage; unexpected contact → stop and inspect. Track occupied channels through restart.

## 3. Basis, risks and next work

**Team assessment:**

- **CALCULATION:** Nominal clearance is only **10 µm per side**: (530 − 510)/2. Tilt consumes that margin. XY or XYZ correction cannot correct pitch/roll. Required angular tolerance depends on actual channel depth, which remains unknown. Trace: REQ-SYS-004, 007.
- **SOURCE-BASED FACT:** UR3e pose repeatability is **±30 µm**; force-sensor accuracy is **3.5 N** ([manufacturer specifications](https://www.universal-robots.com/manuals/EN/HTML/SW10_11/Content/prod-usr-man/complianceUR3e/H_g5_sections/appendix_g5/tech_spec_data.htm)). These specifications do not demonstrate the required alignment or damage-safe contact detection.
- **ENGINEERING JUDGMENT:** Local sensing may simplify calibration, but must observe actual stick tilt and channel position. Tool fiducials alone cannot establish stick alignment. Measuring pickup offsets is established practice ([OpenPnP Bottom Vision](https://github.com/openpnp/openpnp/wiki/Bottom-Vision)); brittle-stick insertion performance remains unproven.

**What could invalidate the recommendation:** Grip/release damage; unobservable tilt; calibration error exceeding clearance; docking-induced slip; occupied-array collisions; inadequate optics/stages within $1,500. The carried stage remains preferable if the station creates these problems. Passive guides remain an option only after damage testing.

**Next five tasks:**

1. **Measure insertion tolerance:** Channel depth/geometry, allowed XY offset, yaw/tilt, seating depth and contact force; define damage and success criteria. REQ-SYS-004, 007.
2. **Test handling:** Mechanical versus vacuum grip; horizontal-to-vertical rotation, slip, release and real-part damage. Surrogates alone cannot establish Bi₂Te₃ damage limits. REQ-SYS-001, 004.
3. **Verify sensing:** Independently measure optical error and tilt observability after rotation and holder swaps. REQ-SYS-006, 007.
4. **Compare architectures:** Same grip, holder and parts; fixed station versus carried correction. Include neighboring occupied channels. Select correction axes from results. REQ-SYS-001, 004, 007.
5. **Demonstrate the complete cycle:** Quoted bill of materials within budget; timing, damage inspection, holder swap and fault recovery. Document larger-stick modifications. REQ-SYS-001–006.

**Proposed milestones:** October—tolerance/handling tests; November—architecture comparison and automatic surrogate cycle; December—real-part demonstration. Dates depend on parts and metrology access. Budget feasibility is **unverified**.

Confidence: high in coarse/fine separation; architecture choice remains open. Verification follows task-based assembly testing ([NISTIR 8090, Shneier et al., 2015](https://doi.org/10.6028/NIST.IR.8090)). Sources checked 1 October 2026. [Recorded team discussion](../records/TASK-001-review-discussion.md).
