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

//-----------------------------------------------------------------------------
// LIBRARY IMPORTS
//-----------------------------------------------------------------------------
include <../config/config.scad>;
include <../utilities/geometry.scad>;
include <../hardware/fasteners.scad>;
include <../hardware/bearings.scad>;
include <../hardware/motors.scad>;
include <../parts/pan/SMK1-001_pan_base.scad>;

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
if (PREVIEW_ASSEMBLY) {
    // Base part.
    SMK1_001_pan_base();

    // Reference standard parts.
    translate([0, 0, 10])
        bearing_608zz(show_keepout = false, show_press_fit = false, show_center_bore = true);

    translate([80, 0, 32])
        nema17(show_mount = false, show_keepout = false);

    translate([-80, 0, 20])
        color([0.2,0.5,0.8,0.3])
            mg996r(show_mount = false, show_keepout = false);

    translate([0, 0, 8])
        slip_ring_placeholder();

    translate([0, -90, 22])
        electronics_enclosure_placeholder();

    // Reference axes and labels.
    axes(120, 2);
    label_text("X", [60, 0, 0], 8);
    label_text("Y", [0, 60, 0], 8);
    label_text("Z", [0, 0, 60], 8);
    label_text("Pan Base", [0, 0, 55], 8);
}
