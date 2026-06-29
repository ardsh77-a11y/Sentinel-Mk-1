/*
===============================================================================
 Sentinel Mk-I
 Modular AI Vision & Acoustic Tracking Platform

 File: utilities/geometry.scad
 Version: 1.0.0
 Revision: A
 License: MIT

 Description:
   Core reusable geometry primitives for the Sentinel CAD Framework.
   This file provides robot-agnostic OpenSCAD modules for general CAD reuse.
===============================================================================
*/

//-----------------------------------------------------------------------------
// CONFIGURATION
//-----------------------------------------------------------------------------
include <../config/config.scad>;

//-----------------------------------------------------------------------------
// GLOBAL SETTINGS
//-----------------------------------------------------------------------------
PREVIEW_GEOMETRY = false;
PREVIEW_FN = 64;

//-----------------------------------------------------------------------------
// HELPER FUNCTIONS
//-----------------------------------------------------------------------------
function _clamp(value, min_value, max_value) = max(min(value, max_value), min_value);
function _valid_radius(value, max_value) = _clamp(value, 0, max_value);
function _safe_dimension(value, min_value) = max(value, min_value);

//-----------------------------------------------------------------------------
// CORE GEOMETRY PRIMITIVES
//-----------------------------------------------------------------------------

// Rounded rectangular prism.
module rounded_box(size = [20, 20, 10], radius = 2, center = true) {
    radius = _valid_radius(radius, min(size) / 2);
    minkowski() {
        translate([radius, radius, radius])
            cube(size - [2 * radius, 2 * radius, 2 * radius], center = center);
        sphere(r = radius, $fn = PREVIEW_FN);
    }
}

// Uniform rounded cube.
module rounded_cube(size = 20, radius = 2, center = true) {
    rounded_box([size, size, size], radius, center = center);
}

// Hollow tube featuring defined inner and outer diameters.
module tube(outer_d = 16, inner_d = 10, height = 20, center = true) {
    outer_d = _safe_dimension(outer_d, 0.1);
    inner_d = _clamp(inner_d, 0, outer_d - 0.1);
    difference() {
        cylinder(d = outer_d, h = height, center = center, $fn = PREVIEW_FN);
        cylinder(d = inner_d, h = height + 2, center = center, $fn = PREVIEW_FN);
    }
}

// Ring with constant thickness.
module ring(outer_d = 30, inner_d = 20, height = 4, center = true) {
    outer_d = _safe_dimension(outer_d, 0.1);
    inner_d = _clamp(inner_d, 0, outer_d - 0.1);
    difference() {
        cylinder(d = outer_d, h = height, center = center, $fn = PREVIEW_FN);
        cylinder(d = inner_d, h = height + 2, center = center, $fn = PREVIEW_FN);
    }
}

// Slotted shape for adjustable mounting or guide features.
module slot(length = 30, width = 6, radius = 3, depth = 4, center = true) {
    width = _safe_dimension(width, 0.5);
    depth = _safe_dimension(depth, 0.5);
    radius = _valid_radius(radius, width / 2);
    translate([0, 0, 0])
        linear_extrude(height = depth, center = center)
            offset(r = radius)
                square([max(length - 2 * radius, 0.1), max(width - 2 * radius, 0.1)], center = true);
}

// Capsule shape with spherical ends.
module capsule(length = 20, diameter = 6, center = true) {
    diameter = _safe_dimension(diameter, 0.1);
    length = max(length, diameter);
    hull() {
        translate([-length / 2 + diameter / 2, 0, 0])
            sphere(r = diameter / 2, $fn = PREVIEW_FN);
        translate([ length / 2 - diameter / 2, 0, 0])
            sphere(r = diameter / 2, $fn = PREVIEW_FN);
    }
}

// Plate with rounded corners.
module filleted_plate(width = 60, depth = 30, thickness = 4, fillet = 2, center = true) {
    width = _safe_dimension(width, 0.1);
    depth = _safe_dimension(depth, 0.1);
    thickness = _safe_dimension(thickness, 0.1);
    fillet = _valid_radius(fillet, min(width, depth) / 2);
    linear_extrude(height = thickness, center = center)
        offset(r = fillet)
            square([max(width - 2 * fillet, 0.1), max(depth - 2 * fillet, 0.1)], center = true);
}

// Wire or cable channel with rounded interior corners.
module wire_channel(width = 12, depth = 5, radius = 2, length = 50, center = true) {
    width = _safe_dimension(width, 0.1);
    depth = _safe_dimension(depth, 0.1);
    radius = _valid_radius(radius, min(width, depth) / 2);
    translate([0, 0, 0])
        linear_extrude(height = length, center = center)
            offset(r = radius)
                square([max(width - 2 * radius, 0.1), max(depth - 2 * radius, 0.1)], center = true);
}

// Mounting tab with a fastener hole for bolted connections.
module mounting_tab(width = 14, height = 22, thickness = 4, hole_d = 3.2, center = true) {
    width = _safe_dimension(width, 0.1);
    height = _safe_dimension(height, 0.1);
    thickness = _safe_dimension(thickness, 0.1);
    hole_d = _clamp(hole_d, 0.1, min(width, thickness));

    difference() {
        cube([width, thickness, height], center = center);
        translate([0, thickness / 2, 0])
            rotate([90, 0, 0])
                cylinder(d = hole_d, h = width + 2, center = true, $fn = PREVIEW_FN);
    }
}

// Vent pattern for airflow openings with repeatable slots.
module vent_pattern(width = 40, depth = 6, thickness = 4, slot_w = 2, spacing = 4, wall = 2, center = true) {
    width = _safe_dimension(width, 0.1);
    depth = _safe_dimension(depth, 0.1);
    thickness = _safe_dimension(thickness, 0.1);
    slot_w = _safe_dimension(slot_w, 0.1);
    spacing = max(spacing, 0.1);
    wall = max(wall, 0.1);

    slot_count = max(floor((width - 2 * wall + spacing) / (slot_w + spacing)), 0);

    difference() {
        cube([width, depth, thickness], center = center);
        for (i = [0 : slot_count - 1]) {
            x = -width / 2 + wall + slot_w / 2 + i * (slot_w + spacing);
            translate([x, 0, 0])
                cube([slot_w, depth + 1, thickness + 1], center = [true, true, true]);
        }
    }
}

//-----------------------------------------------------------------------------
// FUTURE PRIMITIVE MODULES
//-----------------------------------------------------------------------------

// TODO: module magnet_pocket(size = [10, 4, 2], tolerance = 0.2) {
// TODO:   // Implement reusable magnet recess geometry.
// TODO: }

// TODO: module heat_insert_pocket(diameter = 5, depth = 4, tolerance = 0.2) {
// TODO:   // Implement heat-set insert boss geometry.
// TODO: }

// TODO: module countersink(diameter = 6, angle = 82, depth = 1.5) {
// TODO:   // Implement countersink feature for screw heads.
// TODO: }

// TODO: module counterbore(diameter = 6, bore_d = 4, bore_depth = 3) {
// TODO:   // Implement counterbore feature for screw heads.
// TODO: }

// TODO: module embossed_text(text = "Sentinel", height = 1.5, depth = 0.8) {
// TODO:   // Implement embossed text on a surface.
// TODO: }

// TODO: module debossed_text(text = "Sentinel", height = 1.5, depth = 0.8) {
// TODO:   // Implement debossed text on a surface.
// TODO: }

//-----------------------------------------------------------------------------
// PREVIEW EXAMPLES
//-----------------------------------------------------------------------------

if (PREVIEW_GEOMETRY) {
    translate([-160, 0, 0]) rounded_box([40, 20, 12], 3);
    translate([-110, 0, 0]) rounded_cube(18, 3);
    translate([-70, 0, 0]) tube(18, 12, 14);
    translate([-40, 0, 0]) ring(32, 24, 6);
    translate([-5, 0, 0]) slot(40, 8, 4, 6);
    translate([30, 0, 0]) capsule(36, 10);
    translate([70, 0, 0]) filleted_plate(50, 30, 4, 3);
    translate([110, 0, 0]) wire_channel(14, 6, 2, 30);
    translate([150, 0, 0]) mounting_tab(16, 24, 4, 3.2);
    translate([185, 0, 0]) vent_pattern(60, 6, 4, 3, 4, 2);
}
