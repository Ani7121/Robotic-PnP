# TASK-002 automatic exchange — independent concept assessment

Status: PROPOSED. Chief Engineer retains architecture and acceptance authority. Latest user clarification requires automatic finished-holder unloading and new-holder loading. The earlier requirements brief's narrower manual-exchange interpretation is superseded for this assessment.

## Direct recommendation

**ENGINEERING JUDGMENT:** First test a bounded batch on an indexed tray: each holder stays upright in a standardized outer cassette, and one low-cost coarse indexing axis moves the next cassette into the insertion station after the preceding holder finishes. Filled holders travel to an output region of the same tray. No robot holder gripper, toolchanger or tool dock is required. The insertion head remains dedicated to sticks. This is automatic station loading/unloading; cassettes remain attached to their tray. If the intended requirement is physical ejection into a separate output container, a simple through-feed pallet path is the next architecture, and the indexed tray alone does not meet that interpretation.

**ASSUMPTION:** Preloading a finite set of empty holders and stick inventory, then manually removing a completed batch after automatic operation, is permissible. Indefinite replenishment is a different requirement and cannot be silently assumed.

## Candidate comparison

| Candidate | Principle and expected benefit | What could defeat it | Cheapest discriminating test |
|---|---|---|---|
| Indexed batch tray / cassette strip | Move fixtures instead of changing tools; one drive, no release/regrip of fragile filled assembly | Travel and loaded-stick envelope exceed footprint; fixed station cannot reach all targets; fine stage carries too much mass | Full-scale cardboard layout plus two representative filled holders on manually moved tray |
| Separate in/process/out pallet rail | Standard outer cassette makes unknown holder geometry irrelevant to feeder; positive push advances upright pallets | Jam, double-feed, full output, cassette handoff; extra actuator/interlocks | Three dummy cassettes, one process stop, one empty input and one occupied output; deliberately obstruct and misindex |
| UR cassette handling with permanently mounted second gripper | Existing coarse robot moves cassettes, avoiding toolchanger | Wrist mass, reach and camera occlusion from second gripper; collision clearance around exposed sticks | Mock cassette jaws on wrist with inert mass; full swept-envelope trial |
| UR toolchanger plus cassette gripper | Separates tiny-stick and holder tooling | Dock pose, coupler engagement, pneumatic/electrical reliability and budget become new dependencies | Only pursue after fixed gripper and rail layouts demonstrably fail |
| Fixed holder bank under moving insertion head | Deletes holder exchange mechanisms during the batch | Changes task interpretation: visits holders without unloading/loading a station; head travel affects precision and footprint | Obtain explicit functional acceptance before treating this as satisfying automatic exchange |

## Mechanics and process hypotheses

**ENGINEERING JUDGMENT:** Clamp a cassette around robust holder perimeter surfaces, with anti-rotation key and protected insertion-side opening. Use an external handling edge and optional protective fence taller than protruding sticks; never grip sticks or rely on stick protrusions to locate the holder. Provide removable mechanical retention for the empty holder before a batch. Avoid changing holder geometry until Sandia confirms allowed interfaces.

**OPEN QUESTION:** Are inserted sticks retained by a bottom stop, friction, bonding or subsequent process? Upright transport reduces inversion risk but does not establish retention under vibration or acceleration. Filling and safely moving a finished holder are separate demonstrations. A removable underside catch/support can prevent fallout only if geometry and downstream access permit it.

**ENGINEERING JUDGMENT:** Precision insertion and coarse exchange should have separate motion functions. A coarse tray can deliver a cassette into the fine stage's capture region; locate or measure the holder after each exchange. Do not require a long tray axis or plastic cassette to deliver micron positioning by open-loop step count. A fixed reference stop may reduce search range but does not certify final alignment.

**SOURCE-BASED FACT / limited prior art:** Dorner's commercial pallet systems separate transport from a lift-and-locate station and provide pallet/lift sensor mounts. The FlexMove module reports ±0.004 inch repeatability. This supports the transport/locate pattern, not project-scale accuracy, affordability or suitability. [Manufacturer lift-and-locate page](https://www.dornerconveyors.com/products/flexmove/flexmove-pallet-system/lift-locate). **CALCULATION:** 0.004 inch × 25.4 mm/inch = 0.1016 mm = 101.6 µm, exceeding the provisional 5 µm target; pallet placement cannot substitute for final metrology. The commercial unit is prior art, not a purchase recommendation.

## Bounded unattended cycle and failure behavior

**PROPOSED cycle:** Identify and validate preloaded cassette and holder recipe → reserve a known free output destination → locate/secure holder at process station → fill channels with per-channel completion record → verify completion and stick-release/retracted-head condition → release process clamp if present → move filled cassette upright to reserved output → verify destination occupied and process clear → move/locate next cassette → repeat. On tray implementation, output destination is the filled cassette's indexed tray position; no free position can be assumed once tray travel is exhausted.

**ENGINEERING JUDGMENT:** Missing or duplicate cassette, uncertain part release, ambiguous channel completion, loss of pose reference, sticking clamp, blocked output, power interruption, or index sensor disagreement should stop the batch with recorded state. Do not blindly retry holder motion or assume a holder is complete from elapsed cycles. A quarantined cassette position or stop-for-human policy is needed after incomplete insertion; it must not be labeled finished output.

**CALCULATION:** For H loaded holders each requiring N sticks, supply at least H×N valid sticks plus an explicit reject reserve. Ideal bounded time is H×N×t_s + (H−1)×t_e, excluding setup/inspection/recovery, where t_s is measured mean stick cycle and t_e measured holder exchange. If a ≤60 s average includes exchange, required condition is t_s + t_e/N ≤60 s. No values for H, N, t_e or usable inventory are established.

## Feasibility, experiments and confidence

**ENGINEERING JUDGMENT:** A manually assembled indexed cassette tray is likely the lowest added-part-count route to automatic bounded holder exchange. It still adds an axis, cassette interfaces, sensing, guarding and state management; it cannot be declared inside the $1,500 total without a complete BOM. Commercial toolchangers/conveyors have no established budget allocation here. Cassette size, holder channel count, stock allowance and remaining budget are open.

First obtain actual empty/filled holder geometry and retention behavior. Build an unpowered two-cassette tray and execute insertion-station arrival/departure with surrogate loaded holders. Measure worst-case coarse error against fine capture travel; observe collisions, fallout and residual vibration. Then motorize one axis and test deliberate jam, empty slot, exhausted buffer and restart. Actual Bi₂Te₃ damage inspection must follow surrogate tests; surrogates do not establish brittle-part safety. Preserve cassette identity and partially filled status across a stop.

Confidence: moderate in deleting the toolchanger through captive carrier motion; low in exact layout, retention and cost until actual holder geometry and a full-scale sweep are measured. No hardware purchase or accepted design is implied.

## Post-pass architecture comparison and actual exchanged messages

The TPM clarified this is an authorized comparison after TASK-002, so existing comparison assessments were then read. **ENGINEERING JUDGMENT:** The indexed tray concept can serve carried fine-tool/fixed holder, supported-head/moving-holder, or supported-moving-tool/fixed-holder layouts. Moving-holder XY does not inherently make automatic exchange easier. A whole tray on fine XY increases carried mass and populated swept envelope. A coarse tray plus separate nest lift can isolate one carrier for fine motion but adds a transfer, clamp and lower-protrusion interface. Test whether these added interfaces are necessary rather than assuming them.

**Controls → Concept (actual message):**
> Controls first pass: automation should move a known-identity carrier, preserving per-channel states across unload/reload. A shuttle common to both precision layouts may avoid toolchanger complexity; docking only frees UR after a verified physical release. Consider fixed magazine slots/two pallet carriage alternatives with finite fresh/output capacities. Interrupt recovery cannot infer occupancy from last command: unknown holder/channel state must be quarantined or inspected.

**Concept → Mechanical (actual message):**
> Independent concept first pass: delete toolchanger through captive cassette batch tray, coarse one-axis indexing exchanges station occupants upright, fine alignment remains separate. Candidate through-feed rail if distinct input/output ejection required; fixed stationary holder bank is not automatically equivalent to loading/unloading a process station. Please challenge loaded-stick retention/overheight collision, whether coarse tray can locate on fine holder platform without moving full tray, and fixed second UR gripper as toolchanger alternative. Full-scale two-holder manually shifted surrogate tray is first discriminator.

**Mechanical → Concept (actual message):**
> Mechanical independent pass complete: common upright carrier with external handling ears and supported 3-2-1 nest suits all three precision layouts; fixed nest also can receive shuttle. Need separate holder/carrier joint and actual holder pose after clamping. Retention unknown: upright conveyance or passive protective frame does not establish stick retention, and lid contact can damage protruding sticks. What simplest concept avoids contact and overflow/full-output problems within budget? Distinguish one-time unloading from repeated XY motion of populated array.

**Concept → Mechanical (actual message):**
> Simplest bounded concept uses captive tray slots as both incoming empty-holder and outgoing finished-holder storage: filled cassette indexes away but stays upright in its original numbered slot, so no separate output deposit/drop/overflow mechanism. Stop at end of usable tray travel, require finite H preloaded slots; separate physical output magazine would instead require through-feed rail and capacity reservation. Noncontact guard fence can protect from external collision only; it does not retain sticks. Repeat XY of a populated array increases exposure relative to a single unload, so loaded-surrogate tests must include actual planned motion profiles and full insertion population. Separate holder/carrier joint and post-clamp actual holder pose agreed.

**Mechanical → Concept (actual message):**
> Captive cassette tray credible for bounded unattended batch, conditional on permission for completed holder to remain in its pocket and required unload definition. Whole tray on fine platform adds all carriers' mass and occupied envelope; simpler coarse index tray presents one carrier then small nest lift separates it from rail/tray and constrains that carrier only. Lift adds mechanism and lower-stick clearance; not proven cheaper. Fixed second UR carrier grip avoids toolchanger only if wrist payload/offset, collision envelope, fine-stage stiffness and reach remain satisfactory. Protective outer rim prevents handling collision, not axial stick retention. Two-holder upright mockup should include fully populated tallest array and jammed output; no powered ejection of fragile array without retained/support transfer.

**Controls → Concept (actual message):**
> Captive cassette viable only with explicit accepted unload semantics: moving completed holder out of active nest to designated finished-storage position can be automatic unload, but gross XY indexing alone does not remove a carrier or provide separate output ejection. Keep retained completed tray slots reserved and counted. Retention tests need maximum populated occupied envelope, lower-side protrusion and acceleration; upright orientation only removes one obvious inversion hazard. I preserve separate shuttle and UR gripping as alternatives pending actual holder geometry.

**TPM → Concept (actual message):**
> Draft docs/design_reviews/TASK-002-array-exchange.md ready after your independent pass. Challenge carrier shuttle vs captive tray recommendation: user explicitly unload finished/load fresh; a tray only counts if automatic movement clears completed holder from fill station and positions fresh, output safely stored, batch boundaries explicit. No implication endless feed. Accuracy-review draft and record response. Communicator follows.

**Concept → TPM (actual message):**
> Accuracy review: sheet correctly separates gross exchange/fine alignment and retains options. Recommend naming captive indexed tray explicitly as smallest finite-batch candidate under 'shuttle': it automatically removes completed holder from fill station, brings fresh holder, stores completed holder upright in original numbered pocket, and stops at tray end. This satisfies your stated unload interpretation without separate output ejector, conditional on permitted batch definition. Avoid adding lift/nest transfer unless carrying whole tray on fine XY fails mass/envelope test; that adds a distinct mechanism. 'Start with finite preloaded batch' should be 'evaluate a finite preloaded batch pending required capacity' since capacity permission pending. Next test currently one holder cannot demonstrate fresh/output transitions: add two numbered cassettes/full-population dummy envelope and exhausted-buffer test.
