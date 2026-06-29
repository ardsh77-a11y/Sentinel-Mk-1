/*
===============================================================================
 Sentinel Mk-I
 Modular AI Vision & Acoustic Tracking Platform

 File: hardware/motors.scad
 Version: 1.0.0
 Revision: A
 License: MIT

 Description:
   Reusable motor primitives for the Sentinel CAD Framework.
   This library supports stepper, servo, and generic motor geometries,
   mount patterns, and keep-out visualization.
===============================================================================
*/

//-----------------------------------------------------------------------------
// CONFIGURATION
//-----------------------------------------------------------------------------
include <../config/config.scad>;

//-----------------------------------------------------------------------------
// GLOBAL SETTINGS
//-----------------------------------------------------------------------------
PREVIEW_MOTORS = false;
PREVIEW_FN = 64;
MOTOR_COLOR = [0.25, 0.25, 0.25];
MOTOR_MOUNT_COLOR = [0.10, 0.55, 0.85, 0.18];
MOTOR_KEEPOUT_COLOR = [1.00, 0.15, 0.15, 0.18];

//-----------------------------------------------------------------------------
// HELPER FUNCTIONS
//-----------------------------------------------------------------------------
function _clamp(value, min_value, max_value) = max(min(value, max_value), min_value);
function _safe_dimension(value, min_value) = max(value, min_value);

//-----------------------------------------------------------------------------
// MOTOR SUPPORT MODULES
//-----------------------------------------------------------------------------

module motor_keepout(width = 42, depth = 42, height = 30, offset = CLEARANCE, color_value = MOTOR_KEEPOUT_COLOR, center = true) {
    width = _safe_dimension(width, 0.1);
    depth = _safe_dimension(depth, 0.1);
    height = _safe_dimension(height, 0.1);
    offset = max(offset, 0);

    color(color_value)
        translate([0, 0, 0])
            cube([width + 2 * offset, depth + 2 * offset, height + 2 * offset], center = center);
}

module motor_mount_pattern(positions = [[-15, -15], [15, -15], [15, 15], [-15, 15]], hole_d = 3.2, hole_depth = 8, color_value = MOTOR_MOUNT_COLOR, center = true) {
    color(color_value)
        for (pos = positions) {
            translate([pos[0], pos[1], 0])
                cylinder(d = hole_d, h = hole_depth, center = center, $fn = PREVIEW_FN);
        }
}

//-----------------------------------------------------------------------------
// STEPPER MOTORS
//-----------------------------------------------------------------------------

module nema17(width = 42, depth = 42, height = 48, shaft_d = 5, shaft_length = 24,
        show_mount = false,
        show_keepout = false,
        mount_hole_d = 3.2,
        mount_hole_depth = 8,
        mount_positions = [[-15, -15], [15, -15], [15, 15], [-15, 15]],
        tolerance = CLEARANCE,
        body_color = MOTOR_COLOR,
        mount_color = MOTOR_MOUNT_COLOR,
        keepout_color = MOTOR_KEEPOUT_COLOR,
        center = true) {

    width = _safe_dimension(width, 0.1);
    depth = _safe_dimension(depth, 0.1);
    height = _safe_dimension(height, 0.1);

    if (show_keepout)
        motor_keepout(width = width, depth = depth, height = height, offset = tolerance, color_value = keepout_color, center = center);

    color(body_color)
        cube([width, depth, height], center = center);

    translate([0, 0, center ? height / 2 : 0])
        color([0.65, 0.65, 0.65])
            cylinder(d = shaft_d, h = shaft_length, center = false, $fn = PREVIEW_FN);

    if (show_mount)
        motor_mount_pattern(positions = mount_positions, hole_d = mount_hole_d, hole_depth = mount_hole_depth, color_value = mount_color, center = center);
}

module nema17_mount_pattern(positions = [[-15, -15], [15, -15], [15, 15], [-15, 15]], hole_d = 3.2, hole_depth = 8,
        color_value = MOTOR_MOUNT_COLOR, center = true) {
    motor_mount_pattern(positions = positions, hole_d = hole_d, hole_depth = hole_depth, color_value = color_value, center = center);
}

module nema17_keepout(width = 42, depth = 42, height = 48, offset = CLEARANCE,
        color_value = MOTOR_KEEPOUT_COLOR, center = true) {
    motor_keepout(width = width, depth = depth, height = height, offset = offset, color_value = color_value, center = center);
}

//-----------------------------------------------------------------------------
// SERVOS
//-----------------------------------------------------------------------------

module mg996r(width = 40, depth = 20, height = 38, horn_d = 6.0, show_mount = false,
        show_keepout = false,
        mount_hole_d = 3.2,
        mount_hole_depth = 8,
        mount_positions = [[-18, -8], [18, -8], [18, 8], [-18, 8]],
        tolerance = CLEARANCE,
        body_color = MOTOR_COLOR,
        mount_color = MOTOR_MOUNT_COLOR,
        keepout_color = MOTOR_KEEPOUT_COLOR,
        center = true) {

    width = _safe_dimension(width, 0.1);
    depth = _safe_dimension(depth, 0.1);
    height = _safe_dimension(height, 0.1);

    if (show_keepout)
        motor_keepout(width = width, depth = depth, height = height, offset = tolerance, color_value = keepout_color, center = center);

    color(body_color)
        cube([width, depth, height], center = center);

    translate([0, 0, center ? height / 2 : 0])
        color([0.65, 0.65, 0.65])
            cylinder(d = horn_d, h = 10, center = false, $fn = PREVIEW_FN);

    if (show_mount)
        motor_mount_pattern(positions = mount_positions, hole_d = mount_hole_d, hole_depth = mount_hole_depth, color_value = mount_color, center = center);
}

module mg996r_mount_pattern(positions = [[-18, -8], [18, -8], [18, 8], [-18, 8]], hole_d = 3.2, hole_depth = 8,
        color_value = MOTOR_MOUNT_COLOR, center = true) {
    motor_mount_pattern(positions = positions, hole_d = hole_d, hole_depth = hole_depth, color_value = color_value, center = center);
}

module mg996r_keepout(width = 40, depth = 20, height = 38, offset = CLEARANCE,
        color_value = MOTOR_KEEPOUT_COLOR, center = true) {
    motor_keepout(width = width, depth = depth, height = height, offset = offset, color_value = color_value, center = center);
}

//-----------------------------------------------------------------------------
// GENERIC MOTORS
//-----------------------------------------------------------------------------

module dc_motor_placeholder(body_width = 40, body_depth = 30, body_height = 40,
        shaft_d = 5.0,
        shaft_length = 16,
        show_mount = false,
        show_keepout = false,
        mount_hole_d = 3.2,
        mount_hole_depth = 8,
        mount_positions = [[-12, -10], [12, -10], [12, 10], [-12, 10]],
        tolerance = CLEARANCE,
        body_color = MOTOR_COLOR,
        mount_color = MOTOR_MOUNT_COLOR,
        keepout_color = MOTOR_KEEPOUT_COLOR,
        center = true) {

    body_width = _safe_dimension(body_width, 0.1);
    body_depth = _safe_dimension(body_depth, 0.1);
    body_height = _safe_dimension(body_height, 0.1);

    if (show_keepout)
        motor_keepout(width = body_width, depth = body_depth, height = body_height, offset = tolerance, color_value = keepout_color, center = center);

    color(body_color)
        cube([body_width, body_depth, body_height], center = center);

    translate([0, 0, center ? body_height / 2 : 0])
        color([0.65, 0.65, 0.65])
            cylinder(d = shaft_d, h = shaft_length, center = false, $fn = PREVIEW_FN);

    if (show_mount)
        motor_mount_pattern(positions = mount_positions, hole_d = mount_hole_d, hole_depth = mount_hole_depth, color_value = mount_color, center = center);
}

//-----------------------------------------------------------------------------
// TODO: FUTURE MOTOR TYPES
//-----------------------------------------------------------------------------
// TODO: Add NEMA14 motor primitives.
// TODO: Add NEMA23 motor primitives.
// TODO: Add SG90 servo primitives.
// TODO: Add DS3218 servo primitives.
// TODO: Add BLDC motor primitives.
// TODO: Add harmonic drive gearbox primitives.
// TODO: Add planetary gearbox primitives.

//-----------------------------------------------------------------------------
// PREVIEW EXAMPLES
//-----------------------------------------------------------------------------

if (PREVIEW_MOTORS) {
    translate([-60, 0, 0]) nema17(show_mount = true, show_keepout = true);
    translate([0, 0, 0]) mg996r(show_mount = true, show_keepout = true);
    translate([60, 0, 0]) dc_motor_placeholder(show_mount = true, show_keepout = true);
}
