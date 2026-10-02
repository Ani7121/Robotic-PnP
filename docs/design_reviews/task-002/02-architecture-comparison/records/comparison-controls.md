# TASK-002 comparison: electrical and robotics assessment

Status: PROPOSED. Independent comparison, 2 October 2026. No measurements or architecture acceptance. Read constitution, state, task, electrical/robotics roles and TASK-002 report/evidence. This is a comparison after TASK-002, not a new blind requirements-only design.

## Direct assessment

ENGINEERING JUDGMENT: TASK-002 changes the precision reference and actuator placement, not the fundamental need to measure actual stick-to-channel pose. Its potentially shorter local measurement loop is useful only if the dock supports the tool without robot opposition, the actual stick remains observable, and the holder stage delivers calibrated motion at the channel. The original carried positioner remains credible when holder movement/neighbor clearance makes the station costly. Neither architecture has proved superior.

## Transform and uncertainty comparison

CALCULATION (frame identity, not a performance result): Let world W, holder H, end-effector reference E and stick S denote rigid frames. The original chain is T_HS = inverse(T_WH) T_WE T_ES. Holder localization and overhead end-effector localization share W; bottom-up imaging estimates T_ES after pickup. Correlated common camera errors can partially cancel in relative measurements, so treating all terms as independent and adding catalog errors is inappropriate. Depth-dependent projection, differing image locations/heights and time between acquisitions remain. A pickup measurement before rotation/transport is stale if the stick slips, bends or the reference-to-stick relationship changes.

CALCULATION: For station reference D, the equivalent chain is T_HS = inverse(T_DH) T_DS. TASK-002 can estimate these near the insertion region after docking and rotation, reducing dependence on transport calibration. But T_DH may itself contain stage position, holder registration and datum-to-channel calibration; T_DS may contain dock seating, carriage motion and reference-to-stick calibration. Fewer written transforms do not establish lower uncertainty. Local imaging of both actual features is preferable where visible; fixture markers alone do not measure an occluded tip or internal channel axis.

ENGINEERING JUDGMENT: Original carried actuation places motor wiring, grip/vacuum lines and moving mass on the arm; elastic cable forces can change final tool pose. A supported station can reduce moving cable burden and support short local insertion travel, but adds stage wiring, dock-state sensing and control handoff. Moving the holder introduces array travel, flatness, yaw, pitch/roll and Abbe error at the channel height. Calibration must exercise the occupied array and actual travel, not only a central stationary channel.

## Tilt, yaw and visibility

CALCULATION: The nominal 510/530 micrometre geometry permits 10 micrometres per side at zero yaw. For entrance-center error e and projected tilt alpha over engagement h, |e + z tan(alpha)| <= 10 micrometres throughout 0 <= z <= h, before allocating other errors. At h=12 mm, 5 micrometres adverse offset leaves alpha approximately 0.024 degrees. Engagement is unknown; this is a conditional geometry bound, not a requirement. See TASK-002 evidence C1.

ENGINEERING JUDGMENT: A top image of a reference or stick end does not by itself observe the two shaft-tilt components. Bottom-up pickup imaging also does not automatically establish shaft alignment after rotation/support. Either architecture needs validated multi-view shaft measurement, a calibrated depth-sensitive optical method, or measured mechanical angular constraint and bounded straightness. Two separated shaft positions in each projected plane can estimate tilt; the baseline and measurement errors must resolve the actual capture envelope. Square-end imaging can inform yaw but cannot substitute for pitch/roll. XY holder motion and XY carried motion are equally unable to correct tilt; angular constraint or correction is required if measured tilt exceeds tolerance.

## Ownership and stopping

ENGINEERING JUDGMENT: Original coarse-to-fine transition should freeze coarse robot motion, verify grip/pose, enable the fine stage only within its travel limits, and explicitly assign Z to one controller. Holding a robot still does not eliminate its structural compliance or drift. TASK-002 needs an additional dock handshake: engage support, verify latch/contact and pose, release or compliantly isolate the robot coupling, then authorize local axes. The robot must not servo against the stage; ambiguous dock state inhibits insertion. Undocking occurs after verified retract, stage home/clearance and robot reacquisition.

ENGINEERING JUDGMENT: One sequencer should own state transitions; individual controllers need local watchdog and travel limits. Distinguish transport, dock, register, align, insert, release, inspect and recover. Loss of images, communications, grip confirmation or pose confidence invalidates insertion permission. Preserve an uncertain channel as uncertain/occupied until checked. Stop behavior must specify which device retains the stick and which stored energy remains on power loss; indiscriminate motor disable or automatic Z retract can drop, break or pull out a stick.

CALCULATION: Dynamic contact overtravel includes approximately v*tau plus braking travel v^2/(2a), assuming constant latency tau and deceleration a. Peak force also depends on stiffness, inertia and friction. Measure end-to-end detection/filter/network/drive stopping delay at the tool. Station Z may make this easier to characterize than UR Z, but short travel alone does not prove safe contact. Axial sensing can miss corner damage and cannot distinguish seating from a jam. Sources/conditional examples are in TASK-002 evidence C2; no safe load is established.

## Discriminating experiment

ENGINEERING JUDGMENT: Use the same grip and holder to compare (a) robot-held/carried fine alignment and (b) supported local head with holder motion. Measure actual stick and channel pose before rotation, after rotation, after docking and during insertion, including both projected tilts. Apply known offsets to validate optics independently. Record residual pose versus stage travel, populated-neighbor visibility, grip slip, dock loads and end-to-end stopping motion. Stage/encoder resolution is not an accuracy result. Begin with surrogates for geometry/control; real-part trials are needed for damage limits. If docked pose and holder-stage errors do not beat carried alignment within the measured capture envelope, TASK-002 has added complexity without demonstrated benefit.

Confidence: high in the need for local relative metrology, explicit controller ownership and tilt verification; low in either architecture's achievable performance/cost until those tests. Remaining questions: actual depth, channel straightness/tilt, array extent, visibility, dock constraint scheme, contact limits, available optics and motion hardware.

## Actual peer discussion

Pending direct exchange after independent assessment.

Received from /root/compare_mechanics:
> Mechanical first-pass complete: both concepts preserve coarse/fine. Station support improves the load path only with a mechanically defined arm release/compliant coupling; a rigid arm plus station-constrained carriage is overconstrained. Neither XY/XYZ/yaw solves shaft pitch/roll. Recommend same-grip A/B dwell and insertion trials around populated neighbors, measuring stick-to-channel offset/tilt before and after docking. Does a carried stage permit observing residual drift during insertion, and what simplest support/coupling avoids competing motion ownership? Fixed holder + station-supported XY tool remains a third credible arrangement if moving an occupied array is costly.

Sent to /root/compare_mechanics:
> Controls independent assessment: station changes reference/actuator placement, not actual pose metrology. Original chain inverse(T_WH)*T_WE*T_ES becomes local inverse(T_DH)*T_DS, but dock, stage and datum-to-channel errors remain. Carried stage can observe drift only if actual shaft/channel features stay visible at useful bandwidth; a fiducial alone cannot detect slip/bow. Simplest coupling candidate is supported carrier with robot mechanically released after confirmed latch, retaining the same stick grip; compliant coupling is alternative but its residual force must be measured. Ownership should change only after dock verification, robot isolation and post-dock pose/tilt check. Agree on hybrid fixed holder/local supported XY tool: it separates the support benefit from the moving-holder choice.

Received review request from /root:
> Draft comparison sheet at docs/design_reviews/TASK-002-architecture-comparison.md available after first pass. Please accuracy-check and send peer critique mechanics. Record request and actual response.

Sent to /root after reading comparison sheet:
> Accuracy check comparison sheet: sound. Suggested small addition to measurement row/basis: bottom-view stored stick-to-tool transform must be revalidated after rotation if slip/bow is possible; post-support check is not exclusive to station. For stopping, add 'measure end-to-end contact detection and stopping motion' to A/B outcomes because peak contact alone may miss delayed stop. Current sheet already avoids overstating fewer transforms and preserves hybrid.

Received response from /root/compare_mechanics:
> Agree with mechanically released, positively latched carrier as a clearer ownership boundary than uncharacterized compliance. It is a candidate mechanism, not free hardware: latch/preload shift and automatic recoupling need measurement. Support benefit should first be screened with manual release/fixture support; successful screening does not establish automated dock feasibility. Your shaft visibility condition also means a stable fiducial chain cannot rescue unobserved grip slip during insertion.

Synthesis of exchange (ENGINEERING JUDGMENT): screen support with manual robot release first; do not budget or schedule an automated carrier handoff as though established. Preserve continued shaft observation or experimentally bounded grip stability during hidden travel.
