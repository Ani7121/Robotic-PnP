# TASK-002 — Evidence and Feasibility Checks

Supporting reference for the [decision sheet](TASK-002-independent-system-design.md). Status: PROPOSED. No new physical measurements were made. Sources checked 1 October 2026.

## Scope and independence

Five fresh specialist threads received the [requirements-only brief](../../../../tasks/TASK-002-requirements-only.md), role instructions and constitution, with no conversation history. They were instructed not to read prior architectures, TASK-001 reviews or the architecture-bearing project state. Written assessments preceded peer discussion. The synthesis lead already knew the previous design; this was a fresh specialist assessment, not a fully blind lead review. Original submissions and actual engineering messages are preserved in the [discussion record](../records/TASK-002-team-discussion.md).

## C1. Clearance and orientation

**CALCULATION:** For ideal square sections, channel width H=530 µm and stick width b=510 µm give centered clearance c=(H−b)/2=10 µm. For b=500 µm, c=15 µm. These are nominal geometry, not verified minimum clearances.

For zero yaw and a straight rigid stick in a uniform channel:

`max over z in [0,h] |e₀ + z tan(α)| ≤ c`

Apply separately in X and Y. `h` is engaged depth; `e₀` is entry-center error; `α` is the projected tilt. The following entrance-centered examples allocate no margin to other errors:

| Assumed engagement | Ideal tilt at zero offset | Tilt with 5 µm adverse offset |
|---|---:|---:|
| 1 mm | 0.573° | 0.286° |
| 6 mm | 0.0955° | 0.0477° |
| 12 mm | 0.0477° | 0.0239° |

Actual engagement is unknown. Mid-depth centering changes the ideal bound; channel taper, bow, projected width, burrs and measurement uncertainty invalidate a simple nominal allowance. At zero tilt and offset, square yaw requires `b(|cos ψ|+|sin ψ|) ≤ H`, giving approximately 2.293° near zero yaw. Combined yaw/offset/tilt must be evaluated together; square symmetry does not remove pitch/roll.

**ENGINEERING JUDGMENT:** An XY holder cannot correct pitch/roll. The supported head must constrain those angles within the measured envelope or provide measured angular adjustment. A fixture registered on exterior datums cannot replace actual channel registration without evidence of datum-to-channel accuracy. Indexing travel, fine correction travel and holder-swap repeatability are separate checks.

## C2. Contact and cycle-time limits

**CALCULATION — screening examples, not safe settings:** A 0.51 mm square rod treated as a 12 mm cantilever under a 1 mN lateral tip load has nominal root stress `σ=6Fh/b³ ≈0.543 MPa`. This elastic beam model omits flaws, local corner stress and anisotropy; it supplies no fracture threshold. Reducing unsupported length can reduce bending moment but extra supports introduce contact risks.

For insertion speed v and total detection-to-stop latency τ, quasi-static extra travel is approximately `vτ`; for spring stiffness k, extra elastic force is approximately `kvτ`. At illustrative v=0.1 mm/s and τ=80 ms, travel is 8 µm. This is axial compression, not an XY-clearance comparison. Real peak load also depends on inertia, stored energy, friction and drive behavior. Measure the entire loop, including filtering and actuation; ADC sample interval is not total latency.

If seating requires 12 mm travel at 0.1 mm/s, insertion alone takes 120 s. If only 30 s of the 60 s cycle is available for that travel, average insertion speed must be at least 0.4 mm/s. Actual stroke and damage-safe speed decide whether the cycle target is feasible. These are conditional calculations, not selected speeds or allocated cycle times.

**ENGINEERING JUDGMENT:** Axial force cannot distinguish seating from a lateral jam or guarantee detection before corner damage. Use prealignment, a validated compliant/load-limited path, measured stop dynamics and independent seating observation. A hard travel stop alone does not limit contact force.

## Architecture gates and alternatives

| PROPOSED approach | Requirement served / advantage | Gate before automation |
|---|---|---|
| Retained broad grip, supported carrier, local XY holder and Z feed | Automatic handling/insertion; avoids another acquisition | Grip survival, support-induced shift, tilt, local visibility, populated-neighbor and release clearance |
| Docked turnover cartridge/open split cradle | Constrains orientation through fixturing; may reduce active correction | Actual channel/datum error, transfer damage, guide friction, opening sweep and no-pullout release |
| Direct camera-guided robot insertion | Fewer local actuators | Demonstrated residual motion/tilt and peak contact below real-part limits; catalog repeatability cannot answer this |
| Passive contact alignment | May reduce angular actuation | Safe capture range with actual brittle sticks and permitted entrance geometry; reject if correction chips corners |

**Unresolved disagreement:** Retained grip minimizes transfers; supported cartridge may better control the shaft. Compare both with identical representative parts, actual holder geometry and measurement methods. Empty-holder success is insufficient.

**Mechanical interface gate:** A docked carrier needs a compliant or releasable arm coupling that permits local motion without the robot opposing it. Keeping the same grip does not require rigidly connecting the precision carriage to the arm throughout insertion. Verify docking load, stick shift and release; do not command a stage against an overconstrained robot/tool connection.

**Budget/schedule:** No complete vendor quotation or confirmed equipment-loan inventory exists. Minimum bill of materials must include tool/fixture, holder indexing and insertion drives, imaging/optics/lighting, calibration artifact, contact instrumentation/control, power/wiring and any missing protective measures, plus delivery/tax. Reconcile existing spend with the $1,500 total. Borrowed/manual adjustments can support characterization; they do not satisfy final automation. One executor and approximately December completion favor one holder family first, followed by swap testing; stage travel must cover its actual array.

## Edge cases and verification

| Edge case | Required test or response |
|---|---|
| Largest/bowed stick, minimum/tapered channel, debris | Measure actual geometry; reject incompatible parts; map safe offset/angle capture with inspected parts |
| Vacuum leak, double pickup, cracked or slipped stick | Confirm one intact part after rotation/support; pressure alone is insufficient; invalidate prior pose after slip |
| Tip hidden by tool or guide | Validate visibility or bounded straightness/no-slip during hidden travel; fixture markers alone are insufficient |
| Adjacent populated channels and array edges | Test approach, support opening, insertion and retreat at worst occupancy |
| Jam, incomplete seat, pullout on release | Stop on ambiguous contact; verify depth/top height and post-release retention; no blind repeated pushing |
| Sensor/communications loss or power interruption | Inhibit insertion; establish safe holding/stopping behavior for all drives; preserve uncertain/occupied channel state |
| Holder replacement | Re-register; verify channel coordinates, height, tilt and fixture distortion |
| 1 × 1 × 20 mm stick | Require appropriately larger channels; revise grip, travel, optics and collision envelope; do not reuse 530 µm channels |
| Footprint and timing | Verify full swept robot/tool/holder envelope and control box within 3 × 6 ft; measure complete pick-to-place cycle and state retry accounting explicitly |

**CALCULATION — verification proposal:** Zero visible-damage events in 30 independent, representative trials yields one-sided 95% binomial upper damage probability `1−0.05^(1/30)≈9.50%`. This only addresses the stated visible-damage rate, not absence of functional damage or all failure modes. Define supplier-agreed functional inspection and seating criteria before testing; count visible cracks as failures. Surrogate results do not establish real-part fracture/release performance.

## Primary sources and applicability

| ID | Source | Supported fact / limitation |
|---|---|---|
| E1 | [Universal Robots, UR3e technical specifications](https://www.universal-robots.com/manuals/EN/HTML/SW10_11/Content/prod-usr-man/complianceUR3e/H_g5_sections/appendix_g5/tech_spec_data.htm) | ±0.03 mm pose repeatability; 3.5 N force accuracy. Not measured insertion error, minimum detectable load or a safe-force threshold. |
| E2 | [Wereszczak, Kirkland, Jadaan & Wang, Strength of bismuth telluride, 2010, pp.131–140](https://impact.ornl.gov/en/publications/strength-of-bismuth-telluride/) | Peer-reviewed conference contribution; ORNL abstract reports orientation-dependent flexural strength. Material/specimen processing differs; no safe force imported. Abstract reviewed, not full chapter. |
| E3 | [Wason et al., Automated Multiprobe Microassembly using Vision Feedback, IEEE Transactions on Robotics, 2012](https://www.nist.gov/publications/automated-multiprobe-microassembly-using-vision-feedback) | NIST publication abstract describes submillimeter manipulation/insertion with vision feedback and probe-deflection force control. Supports optical-force-sensing precedent, not this geometry, budget or damage capability. Full PDF retrieval unavailable. |
| E4 | [Zhang, A Flexible New Technique for Camera Calibration, IEEE TPAMI, 2000, 22, pp.1330–1334](https://www.microsoft.com/en-us/research/publication/a-flexible-new-technique-for-camera-calibration/); [author technical report MSR-TR-98-71](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/tr98-71.pdf) | Models camera geometry and radial distortion; neither paper establishes our micron uncertainty. Calibrate at actual working geometry and validate against independent known offsets. |
| E5 | [ATI, RCC Remote Compliance Compensator](https://www.ati-ia.com/products/compliance/compensator_product_desc.aspx) | Manufacturer describes lateral/angular compliance for contact-guided assembly. Commercial precedent does not prove safe brittle-stick self-alignment. |
| E6 | [Texas Instruments, ADS1232](https://www.ti.com/product/ADS1232) | Bridge-sensor ADC with 10/80 samples/s options. Bit count/sample rate do not establish force uncertainty or stopping latency. Candidate electronics example, not selected hardware. |
| E7 | [Basler, telecentric lenses](https://www.baslerweb.com/en-us/lenses/telecentric-lenses/) | Perspective-reduction principle. Calibrated conventional optics may suffice; telecentricity does not establish whole-system accuracy or budget fit. |

The legacy UR SW10_6 link in the original Robotics submission returned 404 during review. E1 above is the checked replacement; the archived submission retains its original wording.

All architectural preferences remain ENGINEERING JUDGMENT pending experiments. No tolerance, safe load, cycle time, cost or final acceptance has been verified by this analysis.
