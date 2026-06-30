/*
===============================================================================
 Sentinel Mk-I
 Modular AI Vision & Acoustic Tracking Platform

 File: hardware/fasteners.scad
 Version: 1.0.0
 Revision: A
 License: MIT

 Description:
   Reusable standard fastener geometry for Sentinel CAD Framework.
   This file provides parametric M3 hardware primitives for general use.
===============================================================================
*/

//-----------------------------------------------------------------------------
// CONFIGURATION
//-----------------------------------------------------------------------------
include <../config/config.scad>;

//-----------------------------------------------------------------------------
// GLOBAL SETTINGS
//-----------------------------------------------------------------------------
PREVIEW_FASTENERS = false;
PREVIEW_FN = 64;

//-----------------------------------------------------------------------------
// HELPER FUNCTIONS
//-----------------------------------------------------------------------------
function _clamp(value, min_value, max_value) = max(min(value, max_value), min_value);
function _safe_dimension(value, min_value) = max(value, min_value);

//=============================================================================
// M3 FASTENER PRIMITIVES
//=============================================================================

// Clearance hole for M3 screw heads and shanks.
module m3_clearance_hole(diameter = 3.2, depth = 6, center = true) {
    diameter = _safe_dimension(diameter, 0.1);
    depth = _safe_dimension(depth, 0.1);
    cylinder(d = diameter, h = depth, center = center, $fn = PREVIEW_FN);
}

// Tapped hole for a 3 mm threaded insert or direct M3 tapping.
module m3_tapped_hole(diameter = 3.0, depth = 8, center = true) {
    diameter = _clamp(diameter, 2.5, 3.5);
    depth = _safe_dimension(depth, 1);
    cylinder(d = diameter, h = depth, center = center, $fn = PREVIEW_FN);
}

// Counterbore feature for M3 flat-head fasteners.
module m3_counterbore(outer_d = 6.0, inner_d = 3.2, depth = 3.0, through = false, center = true) {
    outer_d = _safe_dimension(outer_d, inner_d + 0.1);
    inner_d = _clamp(inner_d, 0.1, outer_d - 0.1);
    depth = _safe_dimension(depth, 0.1);

    difference() {
        cylinder(d = outer_d, h = depth, center = center, $fn = PREVIEW_FN);
        cylinder(d = inner_d, h = through ? depth + 2 : depth - 0.1, center = center, $fn = PREVIEW_FN);
    }
}

// Countersink feature for M3 tapered-head fasteners.
module m3_countersink(diameter = 6.0, angle = 82, depth = 2.5, center = true) {
    diameter = _safe_dimension(diameter, 0.1);
    angle = _clamp(angle, 60, 120);
    depth = _safe_dimension(depth, 0.1);

    difference() {
        cylinder(d = diameter, h = depth, center = center, $fn = PREVIEW_FN);
        translate([0, 0, center ? 0 : 0])
            rotate([0, 180, 0])
                translate([0, 0, -depth])
                    cylinder(d1 = 0, d2 = diameter, h = depth, center = false, $fn = PREVIEW_FN);
    }
}

// Pocket for M3 heat-set inserts with optional clearance.
module m3_heat_insert_pocket(outer_d = 6.5, inner_d = 3.2, depth = 4.0, clearance = 0.2, center = true) {
    outer_d = _safe_dimension(outer_d, inner_d + 0.1);
    inner_d = _safe_dimension(inner_d, 0.1);
    depth = _safe_dimension(depth, 0.1);
    clearance = max(clearance, 0);

    difference() {
        cylinder(d = outer_d + clearance, h = depth, center = center, $fn = PREVIEW_FN);
        translate([0, 0, center ? 0 : 0])
            cylinder(d = inner_d, h = depth + 0.5, center = center, $fn = PREVIEW_FN);
    }
}

// Nut trap for captive M3 fasteners.
module m3_nut_trap(width = 7.0, height = 5.5, depth = 4.0, slot_height = 3.0, center = true) {
    width = _safe_dimension(width, 0.1);
    height = _safe_dimension(height, 0.1);
    depth = _safe_dimension(depth, 0.1);
    slot_height = _clamp(slot_height, 0.1, height);

    difference() {
        cube([width, depth, height], center = center);
        translate([0, depth/2 - 0.1, 0])
            cube([width - 0.5, depth + 0.2, slot_height], center = [true, true, false]);
    }
}

//=============================================================================
// TODO: FUTURE HARDWARE SUPPORT
//=============================================================================
// TODO: Add reusable M2 fastener primitives.
// TODO: Add reusable M2.5 fastener primitives.
// TODO: Add reusable M4 fastener primitives.
// TODO: Add reusable M5 fastener primitives.

//=============================================================================
// PREVIEW EXAMPLES
//=============================================================================

if (PREVIEW_FASTENERS) {
    translate([-30, 0, 0]) m3_clearance_hole(3.2, 6);
    translate([0, 0, 0]) m3_tapped_hole(3.0, 8);
    translate([30, 0, 0]) m3_counterbore(6.0, 3.2, 3.0);
    translate([60, 0, 0]) m3_countersink(6.0, 82, 2.5);
    translate([90, 0, 0]) m3_heat_insert_pocket(6.5, 3.2, 4.0);
    translate([120, 0, 0]) m3_nut_trap(7.0, 5.5, 4.0, 3.0);
}
