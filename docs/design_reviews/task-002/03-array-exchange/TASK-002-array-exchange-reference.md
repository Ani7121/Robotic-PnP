# Automatic array exchange — Chief Engineer reference

## 1. Status and context

**PROPOSED; untested.** Automatically unloading finished arrays and loading fresh ones is required ([REQ-SYS-008](../../../../PROJECT_STATE.md#top-level-requirements)). Batch size, stick retention and exchange time remain **OPEN QUESTIONS**. The $1,500 budget is unverified; the Chief Engineer retains decision authority.

## 2. Direct answer

**ENGINEERING JUDGMENT:** Standardize a reusable carrier before comparing exchange mechanisms. The **holder** contains stick channels; the **carrier** supports it and supplies handling surfaces. A shuttle brings carriers into a locating/clamping nest independently of precision-stage placement.

```text
Fresh carrier -> transfer -> nest: locate, clamp, measure, fill
Finished storage <- transfer <- clear tool, release nest
```

Conceptual sequence, not selected hardware or scale.

**ENGINEERING JUDGMENT:** A fixed nest offers the simpler exchange interface: no precision-holder stage return and no repeated populated-holder indexing. This does not prove a winning whole-machine layout. A carried fine stage or supported moving tool can both serve a fixed holder. Moving-holder layouts remain credible but add retention exposure. A supported insertion head frees the UR arm only after physical release; carrier gripping must still be provided.

A **captive indexed tray** could be simpler: completed holders stay in their numbered pockets while the tray brings the next empty holder to the station. It avoids regripping, but carries more occupied mass and needs travel. It qualifies only if retained tray pockets meet the required finished-output workflow. A **separate shuttle** transfers individual carriers and adds handoff interfaces. Neither is demonstrated cheaper; both need finite fresh/output capacity and an exhausted-batch stop.

## 3. How constraint and one cycle work

**SOURCE-BASED PRINCIPLE:** Locators establish position; clamps keep the carrier seated against them ([Carr Lane](https://www.carrlane.com/engineering-resources/fixture-design-principles/locating-clamping-principles/ctl)). Picture a rigid carrier resting against six deliberate contacts:

| Contacts | What they establish |
|---|---|
| 3 underneath | Height and tilt |
| 2 along one side | Side position and rotation in the horizontal plane |
| 1 at an end | Remaining horizontal position |

**ENGINEERING JUDGMENT:** Support strong regions clear of protruding stick ends. Clamp near supports without squeezing channels. The holder must also remain fixed within its carrier. Measure actual holder/channel registration and tilt after clamping; a carrier marker or closed clamp cannot prove correct seating.

Reserve finished storage, seat and measure the fresh holder, fill and verify it, clear the tool, then transfer. Check debris/skew, partly seated sticks, swept clearance, output-full conditions and interrupted transfers. Preserve holder identity and channel status through restart. **Upright travel does not prove stick retention.**

Next: test two numbered carriers with full-population dummy geometry, deliberate seating faults and exhausted-buffer stops; test representative populated-array retention and damage separately.

[Engineering recommendation](engineering/TASK-002-array-exchange.md) · [Evidence and actual specialist discussion](records/TASK-002-array-exchange-discussion.md) · [Communicator review](records/exchange-communicator.md)
