# Sentinel Mk-I Hardware Specification

This document defines the approved mechanical components, fasteners, and assembly conventions for Sentinel Mk-I.

## Fasteners

- Standard fastener: **M3**.
- Preferred lengths should match printed wall thicknesses and insert depths.
- Use heat-set M3 inserts for parts that require repeated assembly.
- Use captive nuts only when routing or part geometry prevents direct screw insertion.

## Bearings

- Bearings are designed to be pressed into printed geometry with explicit tolerances.
- Bearing dimensions and fit offsets must be defined in `config/config.scad`.
- Typical press fit use cases include pan, tilt, and motor interfaces.

## Electrical and Mechanical Interfaces

- Use standardized mounting patterns for electronics and sensor modules.
- Modular interfaces must support future subsystem upgrades without changing the overall robot footprint.
- Track critical interface dimensions in `config/config.scad` and avoid hard-coded values.

## Serviceability

- Design parts for disassembly and maintenance.
- Use chamfers, alignment features, and accessible fastener locations.
- Reserve service fastener locations for parts that are expected to be opened or replaced.
