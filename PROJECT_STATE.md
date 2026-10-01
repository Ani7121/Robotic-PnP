# Project State

> Keep this concise. This is the shared briefing both AI teams read before engineering work.

## Mission
Build an automated, repeatable robotic system to pick horizontally presented high-aspect-ratio bismuth telluride sticks and insert them vertically into array-holder channels without functional damage.

Nominal workpiece:
- 500–510 µm square cross-section
- ~12 mm length

Nominal array-holder channel:
- ~530 µm square

## Current milestone
- Define and validate the system architecture for precision localization, pickup, alignment, and insertion before detailed hardware design.

## Top-level requirements
- REQ-SYS-001: Automatically and repeatably pick and place nominal Bi₂Te₃ sticks into array-holder channels.
- REQ-SYS-002: Target ≤60 s pick-to-place cycle time per stick.
- REQ-SYS-003: System footprint shall not exceed 3 ft × 6 ft.
- REQ-SYS-004: Process shall not functionally damage placed sticks; target <1 visibly damaged stick per 10 placements.
- REQ-SYS-005: Address modifications required for sticks up to 1 mm × 1 mm × 20 mm.
- REQ-SYS-006: System shall support placement into multiple/swappable array holders.
- REQ-SYS-007: Required stick-to-channel positioning/alignment accuracy is TBD experimentally. 5 µm is currently an engineering target, NOT a Sandia requirement.

## Known constraints

### Budget
- Total project hardware budget: $1,500.

### Timeline
- Target date: End of subcontract Period of Performance; around december 2026
- Near-term milestone: Demonstrate reliable localization, pickup, and precision alignment using surrogate sticks and representative array holder.

### Available equipment
- UR3e robotic arm.
- Sandia may provide a LumenPnP if useful.
- Cameras/optics: potential depth camera availability.
- Sandia will provide representative Bi₂Te₃ parts and non-sensitive array holders.
- Sandia will provide tin density-matching surrogate sticks.
- Sandia will provide graphite tribological surrogate sticks.
- Machine tools/metrology available at UT: calipers, machine shop (CNC, lathe, mill, saws)

### Manufacturing capability
- CAD/design capability available.
- 3D printing and conventional machining capability: available. 2 machine shops, each has lathes, mills, one has HAAS Minimill. Both have band saws, taps, measuring tools, and bits. Also have access to basic workshop with drills and other hand tools. 3D printers include Bambu X1Cs and prusas. Also have resin 
- 

## Current accepted architecture

Current leading concept:
1. Array holder is mechanically constrained in a replaceable fixture.
2. Top-down vision localizes the array holder relative to a fixed world reference/fiducial.
3. Stick sorting/presentation provides horizontally oriented sticks in a robot-accessible configuration.
4. UR3e performs coarse manipulation and pickup.
5. Bottom-up vision measures actual stick pose relative to an end-effector reference after pickup.
6. UR3e moves the stick to a position immediately above the target array channel.
7. Top-down vision measures end-effector pose relative to the same world reference used for the array holder.
8. Stick-to-channel relative pose is reconstructed from the measured transforms.
9. A fine micropositioner corrects residual alignment error.
10. Stick is inserted, released, and the process repeats.

Candidate fine-positioner architectures include XY, XYθz, and XYZ parallel/flexure mechanisms. DOFs are not yet selected.

Candidate pickup architectures include compliant mechanical gripping and vacuum. Neither is selected.

## Accepted decisions
- Do not rely on UR3e forward kinematics alone to achieve micron-scale final alignment.
- Separate coarse robot motion from final precision alignment.
- Measure pickup variation rather than assuming the stick occupies a perfectly repeatable gripper pose.
- Treat 5 µm alignment as a provisional derived engineering target until insertion-tolerance testing establishes the actual requirement.
- Do not require the replaceable array-holder fixture itself to mechanically repeat to 5 µm if its pose can be measured after installation.

## Measured facts
- Nominal Bi₂Te₃ stick cross-section: 500–510 µm square.
- Nominal stick length: ~12 mm.
- Nominal array channel: ~530 µm square.
- Worst-case nominal clearance using a 510 µm stick and 530 µm channel: 20 µm total / 10 µm per side when perfectly centered.
- Visible surface cracking is considered unacceptable functional damage.
- No experimental insertion capture envelope has yet been measured.

## Current assumptions
- Sandia's upstream process will ultimately provide horizontally oriented, regularly spaced sticks; a local presentation mechanism may be required for development/testing.
- Relative optical measurement may be more practical than micron-level absolute robot positioning.
- UR3e coarse positioning only needs to place the target inside the fine-positioner's capture range.
- X/Y alignment is likely more important than absolute Z positioning; this remains to be verified experimentally.
- Angular errors may materially affect insertion because of the stick's ~24:1 aspect ratio and square cross-section.
- Passive compliance may be useful for residual angular/insertion error but is not yet accepted.
- Array-holder channel geometry/pitch may be calibrated relative to holder fiducials rather than detecting every channel independently.

## Open technical questions
1. What X/Y and angular alignment errors can be tolerated while maintaining reliable, damage-free insertion?
2. Is the provisional ≤5 µm relative-positioning target actually necessary?
3. What optical architecture can achieve the required relative localization accuracy within budget?
4. What FOV is required for top-down array-holder/end-effector localization?
5. Can one top-down camera provide sufficient FOV and precision, or is coarse/fine imaging required?
6. Which micropositioner DOFs are actually necessary: XY, XYθz, XYZ, or another configuration?
7. What micropositioner travel is required based on UR, fixture, vision, and pickup errors?
8. Mechanical gripper or vacuum pickup?
9. What gripping force can Bi₂Te₃ tolerate without visible damage?
10. How should Z insertion/contact be controlled and detected?
11. How repeatably can the array holder be mechanically constrained?
12. What holder dimensional and channel-position tolerances does Sandia specify?
13. What mechanism is required for automatic replacement of completed array holders?
14. What portion of stick sorting/presentation is Sandia providing versus UT?

## Active risks
- RISK-001: Required insertion tolerance is currently assumed rather than experimentally characterized.
- RISK-002: A wide-FOV top camera may not provide sufficient spatial resolution for micron-scale alignment.
- RISK-003: Angular misalignment may dominate XY positioning error during insertion.
- RISK-004: Mechanical gripping may damage brittle Bi₂Te₃; vacuum may introduce pose uncertainty and system complexity.
- RISK-005: A custom multi-DOF micropositioner may consume excessive budget and development time if unnecessary DOFs are implemented.
- RISK-006: Calibration/transform errors between cameras, fiducials, end effector, stick, and holder may consume the alignment-error budget.
- RISK-007: Automated sorting and array-holder exchange may expand project scope beyond the core insertion problem.

## Next decision required
Experimentally determine the insertion capture envelope versus X/Y offset and angular misalignment using surrogate sticks and representative array holders. Use those results to establish the actual alignment requirement before selecting the vision system or micropositioner architecture.
