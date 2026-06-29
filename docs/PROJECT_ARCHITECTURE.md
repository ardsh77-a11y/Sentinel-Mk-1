# Sentinel Mk-I Project Architecture

This document describes the repository architecture and the intended role of each major directory.

## Repository Structure

- `assembly/` — Top-level assembly models and parent OpenSCAD files.
- `config/` — Global configuration and parameter libraries.
- `docs/` — Project documentation, standards, and changelog.
- `firmware/` — Embedded firmware and software assets.
- `hardware/` — Hardware libraries, motor mounts, and mechanical subsystems.
- `parts/` — Printed part definitions and subassembly modules.
- `utilities/` — Reusable OpenSCAD utilities and helper libraries.

## Design Principles

- Keep configuration centralized in `config/config.scad`.
- Use `utilities/` for generic geometry and behavior helpers.
- Group subsystem parts under `parts/` with clear naming and unique IDs.
- Top-level assemblies in `assembly/` should import only the required modules and configuration.

## Subsystem Interfaces

Major subsystems are defined by interface IDs, ensuring compatibility across revisions.

- `IF-001` — Pan module
- `IF-002` — Tilt module
- `IF-003` — Camera carrier
- `IF-004` — Electronics tray
- `IF-005` — Battery cartridge
- `IF-006` — Rear I/O panel

Interface IDs are the contract boundaries for mechanical and electrical subsystem compatibility.
