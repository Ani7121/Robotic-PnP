# TASK-002 — Chief Engineer Reference

## 1. Status and context

**PROPOSED · 1 October 2026 · Performance has not been demonstrated.**

The task is to pick up a horizontal bismuth telluride (Bi₂Te₃) stick, turn it upright, and place it into a narrow square channel without functional damage. The recommendation separates carrying the stick across the workspace from guiding its final insertion. The existing UR3e does the carrying; a supported tool and locally positioned holder do the close alignment.

The nominal stick is roughly half a millimeter wide: 500–510 µm square and about 12 mm long. A micrometer (µm) is one thousandth of a millimeter. The nominal channel is 530 µm square. Channel depth, actual size variation and damage-safe contact limits remain unknown. The $1,500 budget, approximately December completion and ≤60-second cycle target are constraints, not demonstrated results. [Requirements: REQ-SYS-001–007](../tasks/TASK-002-requirements-only.md)

This reference explains the [engineering recommendation](TASK-002-independent-system-design.md). Its [evidence and calculations](TASK-002-evidence.md) and [actual team discussion](TASK-002-team-discussion.md) remain the technical record. Only the Chief Engineer can accept the design.

## 2. Direct answer

**ENGINEERING JUDGMENT:** Prototype a station where the robot brings the stick to a supported insertion tool, and the holder moves locally to put the selected channel underneath it.

```text
Horizontal stick
      │
      ▼
UR3e + gripper: pick, carry, turn upright
      │
      ▼
Supported tool: hold orientation; short vertical insertion motion
      │               optical check of actual stick and channel
      ▼
Holder: move left/right and forward/back to select and center channel
```

Conceptual division of work; this is not a hardware layout or scale drawing.

The **gripper** holds the stick. The **robot** transports and reorients it. The **local fixture** supports the tool near insertion, while holder motion sets the channel position. Keeping the original grip could avoid another opportunity to chip or misplace the stick. For the local insertion carriage to move, its connection to the robot must yield or release safely; otherwise the carriage would push against the arm. That connection has not been designed yet. [Mechanical interface gate](TASK-002-evidence.md#architecture-gates-and-alternatives)

## 3. Intuitive explanation

**CALCULATION:** For the largest nominal stick, the spare width is 530−510=20 µm. Centering divides that into only 10 µm on each side:

```text
One cross-section, widths greatly exaggerated:

channel wall | 10 µm |<---- 510 µm stick ---->| 10 µm | channel wall
             |<------------- 530 µm ------------->|
```

This is nominal clearance, not a measured tolerance. A small entry-position error spends some of that margin. Tilt spends more as the stick travels deeper: a tip centered at the entrance can still reach a wall farther down.

**SOURCE-BASED FACT:** The UR3e's specified repeatability is ±30 µm. That does not demonstrate positioning within the nominal 10 µm side gap, which is why local alignment needs verification. [Manufacturer data, E1](TASK-002-evidence.md#primary-sources-and-applicability)

```text
Side view of one direction, exaggerated; not to scale:

channel walls; dots trace the tilted stick's centerline
     |         .         |  entrance: centered
     |          .        |
     |           .       |
     |            .      |  deeper: shifted toward wall
     |             .     |

Shift over engaged depth h = h × tan(tilt)
```

For an ideal straight stick, zero entrance offset and **assumed 12 mm engagement**, about 0.048° tilt consumes the 10 µm margin. Actual engagement is unknown. Bow, channel taper, corner rotation and measurement uncertainty also consume room. Moving the holder in XY can center the entrance; it cannot straighten a tilted shaft. The supported tool must hold the measured acceptable angle or provide angular adjustment. [Calculation C1](TASK-002-evidence.md#c1-clearance-and-orientation)

One proposed cycle works as follows:

1. Pick one stick and verify that it is present and intact. Turn it upright, support the tool, then check the actual stick position and tilt again: rotation or docking may change them.
2. Move the selected channel underneath and align locally. Verify shaft tilt in both directions using views or a validated mechanical constraint; fixture markers alone cannot establish the stick's pose.
3. Feed downward with contact limits established by real-part experiments. Unexpected contact means stop and inspect. Force alone cannot tell a bottomed-out stick from one jammed against a wall, and corner damage may occur before a useful axial warning.
4. Verify insertion depth, release the grip, and check that the stick stayed seated. Retreat must clear neighboring installed sticks without lifting the new one. [Verification gates](TASK-002-evidence.md#edge-cases-and-verification)

The credible rival is a supported turnover cartridge: place the horizontal stick in a small cradle, turn the cradle upright, then feed the stick into the channel. Retaining the original grip avoids extra transfers and contact; the cradle may constrain the shaft better. Neither approach has proved superior. Compare both on the same actual, tight-fitting channel surrounded by installed sticks, measuring damage, alignment and release. [Recorded disagreement](TASK-002-team-discussion.md)

**OPEN QUESTIONS:** Actual geometry, safe contact, optical measurement uncertainty and release clearance determine which mechanism works. A successful single-channel experiment is the first gate; automatic multi-channel operation, holder swaps, complete cycle timing and a priced equipment list still need verification. Larger sticks need larger compatible channels and revised tooling. [Next work and feasibility](TASK-002-independent-system-design.md#3-supporting-facts-feasibility-and-next-work)

Communicator engineering-review exchanges are preserved in [the communicator review](TASK-002-communicator-review.md).
