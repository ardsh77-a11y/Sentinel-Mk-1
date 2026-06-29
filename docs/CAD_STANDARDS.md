# Sentinel Mk-I CAD Standards

This document defines the mandatory modeling, printing, and interface conventions for every OpenSCAD file in the Sentinel Mk-I project.

## Printing

- Fits within a **220 × 220 × 250 mm** build volume.
- No supports unless absolutely necessary.
- Default material: **PETG**.
- Minimum wall thickness: **2.4 mm**.
- Minimum fillet radius: **2 mm**.
- Bridge spans should be under **25 mm** when practical.

## Hardware

- Standard fastener: **M3**.
- Use heat-set inserts wherever a part is expected to be serviced repeatedly.
- Use captive nuts only when necessary.
- Bearings are pressed in with defined tolerances from `config/config.scad`.

## Modeling

- No hard-coded dimensions that belong in `config.scad`.
- Every module must have a clear header section.
- Every part must include a unique identifier in the form `SMK1-###`.
- Avoid duplicate geometry; use reusable helper modules whenever possible.

## Interface IDs

Major subsystems are assigned stable interface IDs to preserve compatibility across revisions.

| Interface | Purpose |
|----------|---------|
| IF-001 | Pan module |
| IF-002 | Tilt module |
| IF-003 | Camera carrier |
| IF-004 | Electronics tray |
| IF-005 | Battery cartridge |
| IF-006 | Rear I/O panel |

The interface ID is part of the subsystem contract. If a redesigned subsystem matches the same interface, it remains compatible with the rest of the robot.

## Revision Tracking

Every part header must include revision metadata, for example:

```
Part: SMK1-006
Name: Camera Housing
Revision: A
Compatible: Mk-I Rev A+
```

This ensures that improvements and redesigns are traceable and compatible with existing assemblies.
