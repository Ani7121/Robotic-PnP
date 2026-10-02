# Mechanical comparison: Task 002 and the carried fine stage

**PROPOSED assessment, 2 October 2026. No new physical measurements.**

Read: [constitution](../../../ENGINEERING_CONSTITUTION.md), [state](../../../PROJECT_STATE.md), [Task 002](../../tasks/Task-002), [mechanical role](../../../.codex/roles/senior-mechanical.md), [Task 002 recommendation](../TASK-002-independent-system-design.md), [evidence](../TASK-002-evidence.md), and [Task 001](../TASK-001-system-architecture-process-flow.md).

**ENGINEERING JUDGMENT:** Task 002 preserves the original coarse/fine separation. Its distinctive change is where precision motion is supported: a station-supported insertion tool and moving holder rather than a fine stage supported by the robot. It is a credible alternative, not evidence that the original architecture fails. Task 001 already proposed this comparison.

| Interface | Carried fine stage | Task 002 station |
|---|---|---|
| Structural support | Robot, wrist, stage and grip remain in the load path | Station can support tool and Z carriage locally; benefit depends on actual coupling |
| Holder indexing | Fixed holder; tool travels across array | Holder travels beneath head; stage travel must cover array and full populated-holder envelope |
| Additional interface | Stage mounting and moving wiring | Docking/support acquisition, alignment shift and arm decoupling |
| Same grip retained | Naturally compatible | Compatible if tool/carrier docks without a second stick acquisition |

**ENGINEERING JUDGMENT — support/coupling:** A station does not automatically remove robot compliance. A rigid wrist connection to a station-constrained carriage is an overconstraint; local Z correction can fight the arm or bend the stick. Define a single owner for each constrained axis. Credible options are a releasable tool carrier or a coupling compliant over the entire insertion/correction stroke with verified reaction loads. Re-measure actual stick pose after docking. A carried stage avoids docking but must demonstrate relative drift, settling and angular stability at the insertion dwell; static calibration alone cannot establish this.

**CALCULATION — angles:** For the stated nominal 510 micrometre square stick and 530 micrometre channel, ideal centered margin is 10 micrometres. An entrance-centered straight shaft consumes that margin at tan(alpha)=10 micrometres/h: approximately 0.048 degrees for assumed h=12 mm, or 0.096 degrees at 6 mm. These are geometric illustrations, not measured tolerances. XY, XYZ and XY-yaw stages cannot independently correct shaft pitch/roll. The station may mechanically constrain them, but datum accuracy, stick bow, grip tilt and holder tilt must be demonstrated. Neither architecture currently closes that requirement. See [C1](../TASK-002-evidence.md#c1-clearance-and-orientation).

**ENGINEERING JUDGMENT — moving holder versus tool:** Relative geometry can be corrected by moving either body, but integration costs differ. Moving the holder permits a locally supported head and predictable optical location, at the cost of accelerating installed sticks and translating the whole occupied array. Moving the tool retains a passive holder fixture and avoids those accelerations, at the cost of a larger supported motion or reliance on arm dwell stability. Neither direction inherently supplies micron accuracy. Manual tilt adjustments are suitable for characterization only if repeated pickup/holder-swap angular errors subsequently remain within a demonstrated envelope.

**OPEN QUESTION — populated arrays:** Pitch, protruding height and filling sequence are unknown. Broad side grip, guides, docking hardware and release sweeps may collide with neighbors; holder motion may carry neighbors through stationary structures. Test the deepest interior target with representative installed sticks and array edges. Empty-holder success cannot select either architecture. Filling order can mitigate some collisions but must be compatible with the actual geometry and final occupied array.

**ENGINEERING JUDGMENT — smallest discriminating experiment:** Use the same grip, surrogate, representative channel and imaging arrangement. First establish the offset/tilt capture envelope with a borrowed or manual stage. Then compare (A) wrist-supported retained grip and (B) station-supported retained grip with a mechanically defined arm coupling. Repeat pick/rotate/approach; measure shaft-to-channel offset, pitch/roll and drift through a representative insertion dwell, before and after support acquisition. Insert at one validated trajectory into a channel surrounded by representative neighbors; inspect release/pullout and damage. Record docking failures and elapsed time. Use measurements to decide whether arm support already meets the envelope or station support adds necessary benefit without an interface penalty. Do not fabricate both complete automated systems first.

**Confidence:** High that both remain credible and coupling/angular geometry are decisive; low in either final architecture until the comparison. No BOM or schedule evidence establishes that a station is cheaper. Added docking design competes against carried-stage stiffness/settling work within the $1,500 and December constraints. Chief Engineer retains selection authority.

**ENGINEERING JUDGMENT — hybrid:** A fixed holder with a station-supported local XY tool can preserve a passive array fixture while removing the wrist from the precision load path. Its tool carriage still needs adequate indexing travel, angular alignment and neighbor clearance. Docking is required only if the robot delivers the carrier to that head; a stationary tool with deliberate part transfer is another possibility, carrying its own damage/pose risks. Station support does not logically require moving the holder or docking.

## Actual engineering messages

Messages will be appended verbatim after independent assessment; this section is not reconstructed discussion.

**TPM to Mechanical:**

> TPM comparison framing: both designs are coarse/fine. Compare carried fine stage versus fixed supported head + XY holder, not coarse/fine versus no fine motion. Task1 already proposed station comparison. Challenge station superiority and docking necessity; include hybrid fixed holder/local supported XY tool if it removes full-array stage. Please exchange critique with compare_controls after independent submission. Record this actual message and responses.

**Mechanical to TPM:**

> Independent mechanical assessment written to comparison-mechanical.md. Both are coarse/fine; station superiority is unproved. Crucial station gate is single ownership of constrained axes and release/compliance of wrist coupling. Neither candidate closes pitch/roll merely through XY/XYZ/yaw motion. Compare same retained grip, same populated channel, and measured relative pose/drift before building either full cell. A fixed-holder/local supported XY tool is a credible hybrid when holder travel or neighbor sweeps dominate; will append it and actual exchanges.

**Mechanical to Controls:**

> Mechanical first-pass complete: both concepts preserve coarse/fine. Station support improves the load path only with a mechanically defined arm release/compliant coupling; a rigid arm plus station-constrained carriage is overconstrained. Neither XY/XYZ/yaw solves shaft pitch/roll. Recommend same-grip A/B dwell and insertion trials around populated neighbors, measuring stick-to-channel offset/tilt before and after docking. Does a carried stage permit observing residual drift during insertion, and what simplest support/coupling avoids competing motion ownership? Fixed holder + station-supported XY tool remains a third credible arrangement if moving an occupied array is costly.

**Controls to Mechanical:**

> Controls independent assessment: station changes reference/actuator placement, not actual pose metrology. Original chain inverse(T_WH)*T_WE*T_ES becomes local inverse(T_DH)*T_DS, but dock, stage and datum-to-channel errors remain. Carried stage can observe drift only if actual shaft/channel features stay visible at useful bandwidth; a fiducial alone cannot detect slip/bow. Simplest coupling candidate is supported carrier with robot mechanically released after confirmed latch, retaining the same stick grip; compliant coupling is alternative but its residual force must be measured. Ownership should change only after dock verification, robot isolation and post-dock pose/tilt check. Agree on hybrid fixed holder/local supported XY tool: it separates the support benefit from the moving-holder choice.

**Mechanical to Controls:**

> Agree with mechanically released, positively latched carrier as a clearer ownership boundary than uncharacterized compliance. It is a candidate mechanism, not free hardware: latch/preload shift and automatic recoupling need measurement. Support benefit should first be screened with manual release/fixture support; successful screening does not establish automated dock feasibility. Your shaft visibility condition also means a stable fiducial chain cannot rescue unobserved grip slip during insertion.

**TPM to Mechanical:**

> Draft comparison sheet now at docs/design_reviews/TASK-002-architecture-comparison.md. Please accuracy-check after independent pass and peer exchange. Prioritize any false distinction or unsupported superiority. Append this request and your actual response to recorded messages.

**Mechanical to TPM:**

> Accuracy-check: comparison sheet is mechanically sound and preserves the third layout. One wording refinement: call controlled insertion/release and post-rotation measurement 'made more explicit in Task 002', rather than implying they are exclusive station advantages; original also includes measured pickup and insertion/release. Docking is a conditional implementation burden, not necessary for every station. Prefer 'support acquisition may add operations' in cost/cycle row. Controls agrees supported carrier mechanically released after confirmed latch gives clearer axis ownership; latch shift/recoupling are still unproved. Manual support screening must not be presented as automated dock validation.
