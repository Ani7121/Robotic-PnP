# TASK-002 — Understanding the architecture comparison

## 1. Status and context

**PROPOSED.** Both designs use the same idea: let the robot carry the stick close, then use a separate precision mechanism for final alignment. Task 002 changes where that mechanism sits. Neither layout has demonstrated insertion performance; the Chief Engineer retains the decision. [Engineering comparison](TASK-002-architecture-comparison.md)

## 2. Direct answer: move the stick or move the hole

Picture a vertical stick above a narrow square channel. Bringing their centers together can mean moving either object sideways:

```text
Earlier concept                 Task 002
Robot carries fine stage        Station supports insertion head
         stick                           stick
       <--- --->                           |
           |                               v local insertion
     stationary hole                 <--- hole --->
                                    holder on XY stage
```

Conceptual picture, not to scale; arrows show intended motion, not selected hardware.

In the earlier cycle, the robot picks and turns the stick, measures its relationship to the tool, approaches the holder, and uses the carried stage to finish alignment. In Task 002, it picks and turns the stick, brings the tool to a support station, checks alignment again, moves the holder beneath it, then inserts and releases locally.

**ENGINEERING JUDGMENT:** Station support could reduce the arm's influence, provided the arm connection releases or yields so it does not fight local motion. That benefit is unproved. The carried stage remains credible; a supported moving tool above a fixed holder is another option.

## 3. Why support and tilt matter

Supporting the head does not necessarily straighten the actual stick. Sideways motion can center its tip while its shaft still leans into a channel wall. Both layouts must measure shaft tilt or bound it through a tested mechanical constraint.

**CALCULATION:** Nominal dimensions leave only 10 micrometers per side for the largest stick. Assuming 12 mm engagement, an entrance-centered straight stick uses that margin at about 0.048 degrees tilt. Actual depth, bow and other errors change this allowance; it is not a measured tolerance. [Geometry and evidence](TASK-002-evidence.md#c1-clearance-and-orientation)

**OPEN QUESTION:** Which support arrangement stays aligned through insertion and release without damaging sticks or colliding with filled neighbors?

The smallest useful test first maps safe offset/tilt limits with manual or borrowed metrology, then compares the same grip and holder with arm support and station support. Measure actual alignment, contact, seating, release and time. Surrogates help setup; real parts establish damage behavior. A manual support test does not validate automated docking. [Evidence](TASK-002-evidence.md) · [Discussion](TASK-002-comparison-discussion.md)
