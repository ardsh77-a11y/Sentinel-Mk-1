/*
===============================================================================
 Sentinel Mk-I
 Modular AI Vision & Acoustic Tracking Platform

 File: hardware/bearings.scad
 Version: 1.0.0
 Revision: A
 License: MIT

 Description:
   Reusable bearing primitives for the Sentinel CAD Framework.
   This library supports standard bearing geometries, keep-out zones,
   press-fit visualization, and optional center bore rendering.
===============================================================================
*/

//-----------------------------------------------------------------------------
// CONFIGURATION
//-----------------------------------------------------------------------------
include <../config/config.scad>;

//-----------------------------------------------------------------------------
// GLOBAL SETTINGS
//-----------------------------------------------------------------------------
PREVIEW_BEARINGS = false;
PREVIEW_FN = 96;
BEARING_COLOR = [0.60, 0.60, 0.60];
BEARING_KEEPOUT_COLOR = [1.00, 0.00, 0.00, 0.18];
BEARING_PRESSFIT_COLOR = [0.00, 0.00, 1.00, 0.18];
BEARING_CENTER_BORE_COLOR = [0.00, 1.00, 0.00, 0.18];

//-----------------------------------------------------------------------------
// HELPER FUNCTIONS
//-----------------------------------------------------------------------------
function _clamp(value, min_value, max_value) = max(min(value, max_value), min_value);
function _safe_dimension(value, min_value) = max(value, min_value);
function _bearing_id_valid(value) = _clamp(value, 0.1, 100);

module _bearing_ring(od = 20, id = 10, width = 6, center = true, color_value = BEARING_COLOR) {
    od = _safe_dimension(od, 0.1);
    id = _bearing_id_valid(id);
    width = _safe_dimension(width, 0.1);

    color(color_value)
        difference() {
            cylinder(d = od, h = width, center = center, $fn = PREVIEW_FN);
            translate([0, 0, -0.1])
                cylinder(d = id, h = width + 0.2, center = center, $fn = PREVIEW_FN);
        }
}

//-----------------------------------------------------------------------------
// BEARING SUPPORT MODULES
//-----------------------------------------------------------------------------

// Keep-out region for bearing installation around the part geometry.
module bearing_keepout(od = 20, width = 6, offset = CLEARANCE, color_value = BEARING_KEEPOUT_COLOR, center = true) {
    od = _safe_dimension(od, 0.1);
    width = _safe_dimension(width, 0.1);
    offset = max(offset, 0);

    color(color_value)
        cylinder(d = od + 2 * offset, h = width + 2 * offset, center = center, $fn = PREVIEW_FN);
}

// Pocket geometry for press-fit mounting of a bearing.
module bearing_pocket(od = 20, id = 10, width = 6, tolerance = PRESS_FIT, color_value = BEARING_PRESSFIT_COLOR, center = true) {
    od = _safe_dimension(od, 0.1);
    id = _bearing_id_valid(id);
    width = _safe_dimension(width, 0.1);
    tolerance = max(tolerance, 0);

    color(color_value)
        difference() {
            cylinder(d = od + 2 * tolerance, h = width + tolerance, center = center, $fn = PREVIEW_FN);
            translate([0, 0, -0.1])
                cylinder(d = id, h = width + tolerance + 0.2, center = center, $fn = PREVIEW_FN);
        }
}

//-----------------------------------------------------------------------------
// BEARING MODULES
//-----------------------------------------------------------------------------

// Generic bearing placeholder supporting keep-out, press-fit, and center bore rendering.
module bearing_placeholder(od = 20, id = 10, width = 6,
        tolerance = PRESS_FIT,
        show_keepout = false,
        show_press_fit = false,
        show_center_bore = false,
        base_color = BEARING_COLOR,
        keepout_color = BEARING_KEEPOUT_COLOR,
        press_fit_color = BEARING_PRESSFIT_COLOR,
        center_bore_color = BEARING_CENTER_BORE_COLOR,
        center = true) {

    if (show_keepout)
        bearing_keepout(od = od, width = width, offset = CLEARANCE, color_value = keepout_color, center = center);

    if (show_press_fit)
        bearing_pocket(od = od, id = id, width = width, tolerance = tolerance, color_value = press_fit_color, center = center);

    _bearing_ring(od = od, id = id, width = width, center = center, color_value = base_color);

    if (show_center_bore) {
        color(center_bore_color)
            translate([0, 0, -0.1])
                cylinder(d = id, h = width + 0.2, center = center, $fn = PREVIEW_FN);
    }
}

// Standard 608ZZ bearing.
module bearing_608zz(
        show_keepout = false,
        show_press_fit = false,
        show_center_bore = false,
        tolerance = PRESS_FIT,
        base_color = BEARING_COLOR,
        keepout_color = BEARING_KEEPOUT_COLOR,
        press_fit_color = BEARING_PRESSFIT_COLOR,
        center_bore_color = BEARING_CENTER_BORE_COLOR,
        center = true) {
    bearing_placeholder(
        od = 22,
        id = 8,
        width = 7,
        tolerance = tolerance,
        show_keepout = show_keepout,
        show_press_fit = show_press_fit,
        show_center_bore = show_center_bore,
        base_color = base_color,
        keepout_color = keepout_color,
        press_fit_color = press_fit_color,
        center_bore_color = center_bore_color,
        center = center);
}

// Standard MR85 bearing.
module bearing_mr85(
        show_keepout = false,
        show_press_fit = false,
        show_center_bore = false,
        tolerance = PRESS_FIT,
        base_color = BEARING_COLOR,
        keepout_color = BEARING_KEEPOUT_COLOR,
        press_fit_color = BEARING_PRESSFIT_COLOR,
        center_bore_color = BEARING_CENTER_BORE_COLOR,
        center = true) {
    bearing_placeholder(
        od = 16,
        id = 5,
        width = 5,
        tolerance = tolerance,
        show_keepout = show_keepout,
        show_press_fit = show_press_fit,
        show_center_bore = show_center_bore,
        base_color = base_color,
        keepout_color = keepout_color,
        press_fit_color = press_fit_color,
        center_bore_color = center_bore_color,
        center = center);
}

// Standard 625 bearing.
module bearing_625(
        show_keepout = false,
        show_press_fit = false,
        show_center_bore = false,
        tolerance = PRESS_FIT,
        base_color = BEARING_COLOR,
        keepout_color = BEARING_KEEPOUT_COLOR,
        press_fit_color = BEARING_PRESSFIT_COLOR,
        center_bore_color = BEARING_CENTER_BORE_COLOR,
        center = true) {
    bearing_placeholder(
        od = 5,
        id = 2,
        width = 2.5,
        tolerance = tolerance,
        show_keepout = show_keepout,
        show_press_fit = show_press_fit,
        show_center_bore = show_center_bore,
        base_color = base_color,
        keepout_color = keepout_color,
        press_fit_color = press_fit_color,
        center_bore_color = center_bore_color,
        center = center);
}

// Generic placeholder bearing with configurable dimensions.
module bearing_placeholder_custom(od = 20, id = 10, width = 6,
        show_keepout = false,
        show_press_fit = false,
        show_center_bore = false,
        tolerance = PRESS_FIT,
        base_color = BEARING_COLOR,
        keepout_color = BEARING_KEEPOUT_COLOR,
        press_fit_color = BEARING_PRESSFIT_COLOR,
        center_bore_color = BEARING_CENTER_BORE_COLOR,
        center = true) {
    bearing_placeholder(
        od = od,
        id = id,
        width = width,
        tolerance = tolerance,
        show_keepout = show_keepout,
        show_press_fit = show_press_fit,
        show_center_bore = show_center_bore,
        base_color = base_color,
        keepout_color = keepout_color,
        press_fit_color = press_fit_color,
        center_bore_color = center_bore_color,
        center = center);
}

//-----------------------------------------------------------------------------
// TODO: FUTURE BEARING TYPES
//-----------------------------------------------------------------------------
// TODO: Add 6800 series bearing modules.
// TODO: Add 6900 series bearing modules.
// TODO: Add thrust bearing modules.
// TODO: Add crossed roller bearing modules.

//-----------------------------------------------------------------------------
// PREVIEW EXAMPLES
//-----------------------------------------------------------------------------

if (PREVIEW_BEARINGS) {
    translate([-50, 0, 0]) bearing_608zz(show_keepout = true, show_press_fit = true, show_center_bore = true);
    translate([30, 0, 0]) bearing_mr85(show_keepout = true, show_press_fit = true, show_center_bore = true);
    translate([65, 0, 0]) bearing_625(show_keepout = true, show_press_fit = true, show_center_bore = true);
    translate([90, 0, 0]) bearing_placeholder_custom(od = 20, id = 9, width = 6, show_keepout = true, show_press_fit = true, show_center_bore = true);
}
