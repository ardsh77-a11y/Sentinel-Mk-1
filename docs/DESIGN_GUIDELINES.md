# Sentinel Mk-I Design Guidelines

This document captures the practical design rules and decisions for creating Sentinel Mk-I hardware.

## General Guidelines

- Design every part for 3D printing in PETG.
- Keep geometry simple and avoid overly complex features.
- Use fillets and chamfers to reduce stress concentrations and improve print quality.
- Prioritize serviceability and assembly access.

## Dimensioning

- Reference all key dimensions from `config/config.scad`.
- Avoid magic numbers in modules.
- Use helper variables and functions for repeated geometry patterns.

## Reuse and Modularity

- Create reusable helper modules for standard features like mounting bosses, cable clips, and fastener pockets.
- Organize parts by subsystem and role.
- Reuse common patterns instead of duplicating geometry.

## Part Identification

- Every part must have a unique `SMK1-###` identifier.
- Include a clear module header with description, revision, and compatibility.
- Example part header:

```
Part: SMK1-006
Name: Camera Housing
Revision: A
Compatible: Mk-I Rev A+
```

## Assembly Compatibility

- Define subsystem interfaces with stable interface IDs.
- When redesigning a subsystem, preserve the interface if compatibility is required.
- Document any changes that affect mating parts or mounting geometry.
