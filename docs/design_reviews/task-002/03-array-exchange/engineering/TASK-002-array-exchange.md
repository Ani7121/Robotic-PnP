# TASK-002 — Automatic holder exchange and constraint

## 1. Status and context

**PROPOSED · 2 October 2026 · No exchange or retention tests yet.**

**Question:** Which architecture best supports automatic completed-array unloading and fresh-array loading, and how should holders be constrained?

Automatic exchange is now explicit **REQ-SYS-008**. Earlier manual-swap assumptions applied only to development and do not satisfy the completed system. [Clarified task](../../../../tasks/TASK-002-array-exchange-follow-up.md), [requirements](../../../../../PROJECT_STATE.md#top-level-requirements). Budget remains $1,500; no complete costed solution exists.

## 2. Answer

**ENGINEERING JUDGMENT: Standardize the holder carrier and exchange interface first. Prefer a carrier shuttle into a locating/clamping nest; keep exchange motion separate from final alignment.** This can serve either precision architecture. Task 002 is a convenient starting layout if its moving holder can return to an accessible loading position, but it has no demonstrated exchange advantage.

**For exchange alone, a fixed nest is the simpler starting interface:** no precision-holder stage must return to a transfer position, and the array need not move between channel insertions. This favors a fixed-holder layout for logistics, not necessarily for insertion accuracy. If testing shows station support is needed, retain a fixed holder with a supported moving tool or qualify Task 002's moving holder; do not select the whole cell on exchange convenience alone.

```text
Empty carriers → automatic transfer → locating + clamping nest
                                              ↓
                                     register → fill → verify
                                              ↓
Finished carriers ← automatic transfer ← clear head + release nest
```

Concept only; buffer, feeder and transfer hardware are not selected. Evaluate a finite preloaded batch; required unattended capacity remains TBD. Automatic transfer must include both fresh-carrier supply and finished-carrier storage, with explicit batch limits even for a two-position implementation.

| Layout | Exchange implication |
|---|---|
| Carried fine stage + fixed holder | Fixed nest can accept a separate shuttle. UR exchange instead needs a carrier grip compatible with its insertion tool, or automatic tool exchange. |
| Supported head + XY holder | Stage needs a clear load/unload position and a carrier nest; repeated occupied-array indexing adds retention exposure. UR becomes available only if its tool/carrier is actually released; support alone does not free the wrist. |
| Supported moving tool + fixed holder | Fixed nest/shuttle can keep transport away from precision axes; supported tool travel, transfer and stick handling still need resolution. |

Choose robot carrier handling if its grip and reach are already available and it eliminates more hardware than it adds. Choose a shuttle if it avoids a toolchanger, custom tool dock or reaching over protruding sticks. Neither choice is proven cheaper.

**Simpler batch candidate:** A captive indexed tray keeps holders in numbered pockets: move the completed holder clear of the filling station and bring the next empty holder in. Completed holders stay upright on the tray until batch collection. This avoids regripping and a separate output ejector, if that output arrangement meets the required workflow. Stop at tray end. Evaluate whole-tray mass, travel and occupied clearance before adding a separate transfer/lift mechanism.

## 3. Constraint, failure cases and next test

**SOURCE-BASED PRINCIPLE:** Use separate locators and clamps: **3 bottom contacts, 2 side contacts, 1 end contact**, with preload keeping contacts seated. This locates a rigid carrier against translation and rotation; it does not guarantee channel accuracy. [Carr Lane fixture principles](https://www.carrlane.com/engineering-resources/fixture-design-principles/locating-clamping-principles/ctl), checked 2 October 2026. This machining-fixture reference supports the locating principle, not brittle-stick insertion performance.

**ENGINEERING JUDGMENT — proposed implementation:** Mount each holder in a reusable carrier with protected side handling features. Locate the carrier, support the holder under strong regions clear of any protruding stick ends, and apply limited clamp load near supports. The holder-to-carrier joint must also prevent slip without distorting channels; check actual holder features, not only carrier markers. Use keyed orientation and lead-ins for coarse loading, then seat on deliberate datums. Keep clamps, rails and gripping features below/outside the populated-stick envelope. Re-measure channel registration and holder tilt **after clamping**; visible fiducials alone cannot establish channel-axis alignment. Do not squeeze the channel region or demand a 5 µm pallet repeatability without a measured need. Two round locating pins can bind; a round/diamond pair is an alternative if suitable carrier holes exist. [Pin principle](https://www.carrlane.com/product/locating-pins/locating-pins/diamond-nose-pins).

**Critical edge cases:**

- **Finished sticks move or fall out:** Holder clamping does not retain sticks. Establish retention and permissible tilt/acceleration before transporting a populated array; upright travel is not proof of retention.
- **Carrier is present but not seated:** Debris, skew, wrong orientation or a clamp closing on a high carrier can change tilt. Verify seating separately from clamp state; inhibit insertion on disagreement.
- **Exchange hits a stick:** Clear the insertion tool first; check swept paths with maximum protrusion, full occupancy and an abnormal partly seated stick. Never slide an inserted stick sideways out of a still-engaged tool.
- **Input empty/output full:** Reserve finished storage before starting an array and confirm it again before unclamping; stop without dropping the current carrier. Separate rejected/uncertain arrays from completed arrays.
- **Power loss or interrupted transfer:** Define passive retention and restart checks. Preserve carrier identity and channel state; reconcile actual source/destination identity before replaying an interrupted action. Unknown completion cannot be treated as an empty array.

**Next experiment:** Two numbered carriers, a representative holder and full-population dummy geometry. Repeat automatic clamp/release with deliberate skew/debris and both empty/full geometry; measure seating, channel pose and deformation. Transport a representative populated array upright along a guarded trial path; inspect retention, damage and stopping behavior before expanding to multiple carriers. Use inert replicas for collisions, real parts for retention/damage conclusions. Test finished-to-fresh transitions and exhausted-buffer stopping. Then price the feeder, transfer, output capacity, sensors and precision hardware together.

**CALCULATION:** With N sticks, mean insertion-cycle time t and exchange time E, array time is approximately `N·t + E` (serial operation, excluding setup/retries). Exchange allocation and whether ≤60 s/stick includes its amortized share remain open. [REQ-SYS-002](../../../../../PROJECT_STATE.md#top-level-requirements).

**Confidence:** High that a common carrier interface preserves architecture options; low in the best transfer mechanism until holder geometry, retention, capacity and costs are known. [Plain-language reference](../TASK-002-array-exchange-reference.md) · [Assessments and recorded discussion](../records/TASK-002-array-exchange-discussion.md)
