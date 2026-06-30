/*
===============================================================================
 Sentinel Mk-I
 Modular AI Vision & Acoustic Tracking Platform

 File: assembly/SMK1-000_preview.scad
 Version: 1.0.0
 Revision: A
 License: MIT

 Description:
   Preview assembly for Sentinel Mk-I showing the current pan base model,
   standard bearing, motor, and enclosure placeholders. This file is intended
   for fit-checking, visualization, and early layout validation.

 Recommended View:
   OpenSCAD: View -> 3D View. Use $v = [0,0,200] and $a = [45,45,0] for a good
   starting orientation. Enable "Center view to origin" for consistent previews.
===============================================================================
*/

//-----------------------------------------------------------------------------
// PREVIEW CONTROL
//-----------------------------------------------------------------------------
PREVIEW_ASSEMBLY = true;
PREVIEW_EXPLODED = false;

//-----------------------------------------------------------------------------
// LIBRARY IMPORTS
//-----------------------------------------------------------------------------
include <../config/config.scad>;
include <../utilities/geometry.scad>;
include <../hardware/fasteners.scad>;
include <../hardware/bearings.scad>;
include <../hardware/motors.scad>;
include <../parts/pan/SMK1-001_pan_base.scad>;
include <../parts/pan/SMK1-002_pan_ring.scad>;
include <../parts/pan/SMK1-003_slip_ring_holder.scad>;
include <../parts/pan/SMK1-004_stepper_mount.scad>;
include <../parts/pan/SMK1-005_pan_bearing_retainer.scad>;

//-----------------------------------------------------------------------------
// AXES & HELPERS
//-----------------------------------------------------------------------------
module axes(length = 100, shaft = 1) {
    color([1,0,0])
        translate([length/2,0,0])
            cube([length, shaft, shaft], center = true);
    color([0,1,0])
        translate([0,length/2,0])
            cube([shaft, length, shaft], center = true);
    color([0,0,1])
        translate([0,0,length/2])
            cube([shaft, shaft, length], center = true);
}

module label_text(text_label, pos = [0,0,0], size = 6) {
    translate(pos)
        rotate([90, 0, 0])
            linear_extrude(height = 1)
                text(text_label, size = size, halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
}

//-----------------------------------------------------------------------------
// PLACEHOLDER INTERFACES
//-----------------------------------------------------------------------------
module slip_ring_placeholder(diameter = SLIP_RING_DIAMETER + 10, height = SLIP_RING_LENGTH, center = true) {
    color([0.8, 0.2, 0.2, 0.25])
        cylinder(d = diameter, h = height, center = center, $fn = 64);
}

module electronics_enclosure_placeholder(width = BOX_WIDTH, depth = BOX_DEPTH, height = BOX_HEIGHT, center = true) {
    color([0.15, 0.15, 0.35, 0.25])
        cube([width, depth, height], center = center);
}

module ghosted_motor(color_value = [0.2,0.5,0.8,0.3]) {
    color(color_value)
        mg996r(show_mount = false, show_keepout = false);
}

//-----------------------------------------------------------------------------
// ASSEMBLY PREVIEW
//----------------------------------------------------------------------------- 
module _exploded_offset(exploded, vector) {
    if (exploded)
        translate(vector)
            children();
    else
        children();
}

if (PREVIEW_ASSEMBLY) {
    exploded = PREVIEW_EXPLODED;

    // Base part.
    _exploded_offset(exploded, [0,0,0]) {
        SMK1_001_pan_base();
    }

    // Pan ring assembly.
    _exploded_offset(exploded, [0, 0, 20]) {
        SMK1_002_pan_ring();
    }

    // Bearing retainer and bearing.
    _exploded_offset(exploded, [0, 0, 10]) {
        SMK1_005_pan_bearing_retainer();
        translate([0, 0, 10])
            bearing_608zz(show_keepout = false, show_press_fit = false, show_center_bore = true);
    }

    // Stepper mount and motor placeholder.
    _exploded_offset(exploded, [80, 0, 20]) {
        SMK1_004_stepper_mount();
        translate([0, 0, 32])
            nema17(show_mount = false, show_keepout = false);
    }

    // Slip ring holder and placeholder.
    _exploded_offset(exploded, [-80, 0, 20]) {
        SMK1_003_slip_ring_holder();
        translate([0, 0, 8])
            slip_ring_placeholder();
    }

    // Reference axes and labels.
    axes(120, 2);
    label_text("X", [60, 0, 0], 8);
    label_text("Y", [0, 60, 0], 8);
    label_text("Z", [0, 0, 60], 8);
    label_text("Pan Base", [0, 0, 55], 8);
}
