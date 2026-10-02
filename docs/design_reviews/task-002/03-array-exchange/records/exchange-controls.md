# TASK-002 automatic array exchange: electrical and robotics assessment

Status: PROPOSED, 2 October 2026. New Chief Engineer requirement: automatically unload finished arrays and load fresh arrays. This supersedes the requirements-only brief's earlier statement that automatic exchange was not explicit. No measurements or design acceptance.

## Direct recommendation

ENGINEERING JUDGMENT: Compare the precision architectures with the same carrier-based exchange concept first. A guided pallet shuttle/indexer with separately addressable fresh and finished positions can serve a fixed-holder/carried-head layout or a moving-holder/docked-head layout. Precision holder motion must stop, retract to a verified exchange configuration and release its carrier clamp before either transfer. This separates automatic logistics from micrometre alignment without pretending their interfaces are independent.

ENGINEERING JUDGMENT: Station docking does not automatically make the robot available for array exchange. The arm must physically release its insertion head, retain that head positively, and acquire a suitable holder-handling grip. A bare flange is not a holder gripper. Robot exchange therefore requires a dual-function tool, an exchange grip attached to a compatible coupling, or another automatic tool-change step. The carried-microstage layout likewise needs a dual-function gripper, toolchanger or independent shuttle. A docked head can be advantageous for tool availability only if the necessary release, service connections and reacquisition are demonstrably implemented.

## Candidate tradeoffs

| Candidate | Integration and controls | Principal uncertainty |
|---|---|---|
| Common independent pallet shuttle/indexer | Own coarse actuator(s), clamps, endpoint/occupancy sensors; UR/head remains clear during exchange; local holder registration after transfer | Transfer direction, occupied array swept envelope, fresh/output capacity; added mechanism and wiring |
| UR exchange after head docking | Dock latch confirmed; robot/head decoupling confirmed; holder grip acquisition confirmed; collision-safe pallet trajectories; reacquire insertion tool and remeasure pose | Automatic docking and tool availability are unproven; required grip/toolchange costs can erase the apparent saving |
| UR exchange with carried microstage | Integrated holder grip or automatic tool change; carrier clamp and grip handshake; stored TCP/tool identity selected only after confirmation | More flange envelope, precision-head exposure, utility connections and calibration changes |
| Two-position carriage with preloaded carriers | Few transfer operations; controller tracks which carrier occupies each position | Provides limited unattended batch, not indefinite magazine feed; finished storage and replenishment still required |

ENGINEERING JUDGMENT: Coarse exchange location need not mechanically repeat to the provisional 5 micrometres if the seated holder is freshly measured and precision correction remains within capture travel. A datum that is repeatable but incorrectly seated is insufficient: clamp/contact/presence checks and plausible measured pose are separate conditions. Holder identity should select channel geometry and coordinate map; unexpected identity/orientation inhibits insertion.

## Explicit transaction and interlocks

ENGINEERING JUDGMENT: Use one supervisory sequencer with exclusive ownership of insertion and exchange motion. Suggested exchange transaction:

1. Mark current holder `complete pending inspection` or `quarantine`; stop new picks; verify no stick remains in the insertion grip and Z/head is at a validated clearance position.
2. Reserve an empty output slot before unclamping the finished carrier. Verify destination presence/emptiness and required transfer route.
3. Confirm exchange mechanism has positively retained the carrier, then release station clamp. Confirm removal and output seating before marking that output slot occupied.
4. Reserve a known fresh carrier; verify identity/orientation/presence. Transfer and positively seat/clamp it; confirm transfer mechanism has released and cleared.
5. Measure new holder pose, validate expected geometry/capture range, restore that holder's channel map, and only then enable insertion.

ENGINEERING JUDGMENT: Sensor set depends on chosen mechanism, but requires observability of source presence, destination occupancy, grip/carrier retention, station clamp state, head clearance and tool/dock identity. End-of-travel alone does not prove a carrier was transferred. Disagreeing sensors or implausible vision stop advancement and preserve an uncertain transaction. Ordinary process I/O is not evidence of safety-rated protective functions; safeguarding must be engineered around actual hazards and equipment instructions.

ENGINEERING JUDGMENT: Register handshakes should carry command sequence, acknowledged sequence, expected holder/tool identity and watchdog age. A retained boolean `ready` can otherwise authorize a stale operation after a reconnect. SOURCE-BASED FACT: UR RTDE inputs retain the last received value, permit one client to control each variable, and output packages may be skipped under controller load. Thus nominal publication rate is not a guaranteed freshness or stopping-time bound. See [Universal Robots RTDE guide](https://docs.universal-robots.com/tutorials/communication-protocol-tutorials/rtde-guide.html). Controller/software version must be checked for this UR3e; the source is a general interface description, not a tested project implementation.

## Identity, interruption and finite batches

ENGINEERING JUDGMENT: Persist `holder ID -> channel map` with states such as empty, insertion in progress, filled pending inspection, verified, rejected and unknown; record orientation, geometry revision and pose-registration validity separately. Before a physical action, record its intent; after sensor-confirmed completion, record its result. On restart, reconcile journal against actual source/destination presence and holder identity. Do not replay a transfer or insertion merely because its last acknowledgement is absent. A interrupted insertion must not be retried into a possibly occupied channel. An interrupted holder transfer must remain retained if possible and require inspection/reconciliation before autonomous continuation.

CALCULATION: If F fresh holders and O available finished slots are present, additional unattended completed holders are bounded by min(F,O), further limited by stick supply, consumables and rejects. If a holder is already active its contribution depends on whether F includes it; state the convention. Two carriers support only a finite batch unless another mechanism replenishes/empties positions. Define automatic fresh-empty or output-full stop as normal completion, not a machine fault.

CALCULATION: With N placements per holder and nonoverlapped exchange duration t_exchange, effective time per placement is t_pick_place + t_exchange/N. No exchange duration or N is established. Clarify whether REQ-SYS-002 applies only pick-to-place or batch average before claiming compliance. No unattended duration can be claimed from holder exchange alone.

## Occupied clearance and retention

ENGINEERING JUDGMENT: Collision planning must use the filled array's worst-case occupied height, not an empty fixture CAD model. Include stick protrusion, tilt, tool/grip sweep, camera mounts, clamp actuation and the shuttle/robot motion envelope. Protrusion cannot be equated to nominal stick length without channel-depth/seating data. Larger 20 mm sticks require repeating the envelope and retention assessment. Motion acceleration and clamp jerk must be demonstrated not to loosen, crack or eject sticks. Holder identity links a conservative occupancy envelope to planning; unknown placement height demands the conservative clearance route or a stop.

## Verification, costs and confidence

ENGINEERING JUDGMENT: Before selecting logistics hardware, run a surrogate carrier transfer mockup with a fully populated maximum-height array. Test fresh-empty/output-full operation, misorientation, missing carrier, retained carrier despite release command, grip/clamp disagreement, interrupted transfer and restart. Demonstrate no automatic double insertion or lost holder identity. Measure exchange time, seating variation/capture range, occupied clearance and actual loaded-array retention. Screen a common shuttle and robot grip sequence with the same carrier interfaces.

OPEN QUESTION: Actual holder dimensions, mass, channel count/depth, stick retention after release, grip-access faces, magazine counts, available remaining hardware budget and required unattended batch duration are unknown. Cost and schedule cannot be responsibly quantified yet. Qualitatively the extra actuators/sensors of a shuttle compete with the couplings/tool grip/utility routing of robot exchange; both need engineering, fabrication and commissioning inside the $1,500 total and December target. A dock cannot be treated as free exchange infrastructure.

Confidence: high that explicit transfer ownership, persistent identity/state, occupied clearance and finite capacity are necessary; moderate that carrier-based exchange is the cleanest common comparison; low in any mechanism cost or successful unattended operation until mockup trials.

## Actual peer discussion

Sent to /root/exchange_mechanical:
> Controls first pass: prefer common pallet shuttle/indexer across precision layouts if feasible, because docked support does not imply UR flange is free. Robot-based exchange requires mechanically released head plus holder grip, or carried-head toolchanger/integrated secondary grip. Loaded pallet transfer must clear maximum protruding sticks and hold them through acceleration. What passive carriage/retention arrangement handles finished arrays without overhead pickup over occupied channels?

Sent to /root/exchange_concept:
> Controls first pass: automation should move a known-identity carrier, preserving per-channel states across unload/reload. A shuttle common to both precision layouts may avoid toolchanger complexity; docking only frees UR after a verified physical release. Consider fixed magazine slots/two pallet carriage alternatives with finite fresh/output capacities. Interrupt recovery cannot infer occupancy from last command: unknown holder/channel state must be quarantined or inspected.

Received from /root/exchange_mechanical:
> Mechanical independent pass complete. Outside carrier ears/rim below occupied envelope allow carrier grip without passing jaws over channels; three bottom pads plus 2 side/1 end contacts, supported hold-down and compliant side preload define nest. Need bottom clearance for possible protruding stick ends. Upright transport does not prove retention; actual populated transfer/inspection is mandatory, including lateral bending. Agree fixed nest can use shuttle too, but shuttle adds actuator/payload exchange corridor and loaded transfer still needs latch/retention. Docked tool does not automatically free wrist; robot exchange needs confirmed release and carrier grip/tool change. How will controller verify actual holder seating rather than carrier fiducial alone?

Sent to /root/exchange_mechanical:
> Agree outside carrier ears and bottom protrusion envelope. Seating should combine physical contact/gap sensing at supported contacts (or accessible optical gap inspection), clamp-state sensing, carrier pose plausibility and actual holder fiducial/geometry check. Holder-to-carrier slip remains hidden if only carrier marker is read, so secure holder mechanically and measure holder features after exchange. Cheap experiment: shim one pad, block side datum, loosen holder within carrier; test which defect each proposed check catches. Clamp-closed alone is explicitly insufficient.

Received from /root/exchange_concept:
> Concept first pass favors indexed captive cassette tray for finite batch: one gross indexing axis moves upright filled holder away and fresh holder into process, dedicated stick tool unchanged. This meets automatic station load/unload only if physical separate output ejection is not required; rail in/process/out is next option if it is. Fine XY cannot serve gross tray exchange by assumption. Reserve output before fill; track tray slot identity and exhausted travel; unknown release/channel status stops or quarantines. Key challenge: filled-holder retention is unproven despite upright orientation; require loaded surrogate transport before automation.

Sent to /root/exchange_concept:
> Captive cassette viable only with explicit accepted unload semantics: moving completed holder out of active nest to designated finished-storage position can be automatic unload, but gross XY indexing alone does not remove a carrier or provide separate output ejection. Keep retained completed tray slots reserved and counted. Retention tests need maximum populated occupied envelope, lower-side protrusion and acceleration; upright orientation only removes one obvious inversion hazard. I preserve separate shuttle and UR gripping as alternatives pending actual holder geometry.

Post-discussion synthesis (ENGINEERING JUDGMENT): index-to-storage is a credible bounded-batch alternative when the Chief Engineer accepts that station-unload interpretation; do not silently substitute it for required physical output delivery. Reserve output before starting the last available holder, not only before release, to prevent a completed array becoming stranded. Seating checks need actual holder registration and verified mechanical contact; test their defect coverage using deliberately misseated surrogates. Follow-up read: [automatic exchange task](../../../../tasks/TASK-002-array-exchange-follow-up.md), requirement REQ-SYS-008.

Received review request from /root:
> Draft TASK-002-array-exchange.md accuracy review please after peer critiques. Include finite tray indexing alternative if meets finished unloading/fresh loading at station, explicit input/output capacity. Confirm dock does not itself free wrist, destination reservation before release, restart retention. Record actual response and request.

Sent to /root:
> Review TASK-002-array-exchange.md: sound; docking/free wrist, seating≠clamp and reserve output before unclamping are accurate. Recommend add one finite captive cassette/tray alternative: gross indexing removes finished holder from active nest to designated retained output slot and brings fresh holder in; satisfies station unload only if that output interpretation is accepted, otherwise separate ejection needed. Capacity min(fresh holders, available finished slots), limited additionally by sticks/rejects; reserve output before filling last holder to avoid stranded finish. Current two-position sentence should mean inadequate unspecified buffers, not categorical exclusion of a legitimate finite two-holder batch. Restart must reconcile sensed source/destination identity before replay; preserve possibly filled channels unknown, never automatic retry.
