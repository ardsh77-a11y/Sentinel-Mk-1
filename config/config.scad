/*
===============================================================================
 Sentinel Mk-I
 Modular AI Vision & Acoustic Tracking Platform

 File: config.scad
 Description: Global parameter library and engineering conventions.
              Every geometry module should reference this file.

 Revision: Rev A
 Version: 1.0.0
 License: MIT
===============================================================================
*/

//=============================================================================
// PROJECT METADATA
//=============================================================================
PROJECT_NAME = "Sentinel Mk-I";
PROJECT_VERSION = "1.0.0";
PROJECT_REVISION = "A";
PROJECT_AUTHOR = "Sentinel Mk-I Engineering Team";
PROJECT_LICENSE = "MIT";

//=============================================================================
// BUILD CONTROL
//=============================================================================
BUILD_DEBUG = false;
SHOW_REFERENCE_GEOMETRY = false;
SHOW_HARDWARE = true;
SHOW_ELECTRONICS = true;
SHOW_LABELS = false;
SHOW_PRINT_BOUNDARY = false;

//=============================================================================
// PRINT & MATERIAL
//=============================================================================
PRINT_NOZZLE = 0.40;
PRINT_LAYER_HEIGHT = 0.20;
PRINT_WALLS = 4;
PRINT_INFILL = 20;
PRINT_OVERHANG_TOLERANCE = 45;
DEFAULT_MATERIAL = "PETG";
DEFAULT_FILAMENT_DIAMETER = 1.75;

//=============================================================================
// TOLERANCES & FITS
//=============================================================================
SCALE_FACTOR = 1.0;
PRESS_FIT = 0.15;
SLIP_FIT = 0.30;
CLEARANCE = 0.25;
SHELL_CLEARANCE = 0.50;

function fit_press(d) = max(d - PRESS_FIT, 0);
function fit_slip(d) = d + SLIP_FIT;
function fit_clearance(d) = d + CLEARANCE;
function fit_shell(d) = d + SHELL_CLEARANCE;

//=============================================================================
// UNIT CONVENTIONS
//=============================================================================
UNIT = "mm";
INCH = 25.4;

function mm(value) = value;
function inches(value) = value * INCH;

//=============================================================================
// HARDWARE & FASTENERS
//=============================================================================
MATERIAL_STEEL = "Steel";
MATERIAL_ALUMINUM = "Aluminum";
MATERIAL_PETG = "PETG";
MATERIAL_ABS = "ABS";

FASTENER_M3 = "M3";
FASTENER_M2_5 = "M2.5";
FASTENER_M4 = "M4";
SCREW_STANDARD = FASTENER_M3;

M3_SHOULDER_LENGTH = 10;
M3_HEAD_DIAMETER = 5.5;
M3_THREAD_DIAMETER = 3.0;
M3_WASHER_OUTER = 10;
M3_WASHER_INNER = 3.2;

//=============================================================================
// BASE ASSEMBLY
//=============================================================================
BASE_WIDTH = 250;
BASE_DEPTH = 200;
BASE_THICKNESS = 6;
BASE_WALL = 8;
BASE_SUPPORT_RIB = 10;
BASE_FILLET = 6;

//=============================================================================
// ELECTRONICS ENCLOSURE
//=============================================================================
BOX_WIDTH = 140;
BOX_DEPTH = 100;
BOX_HEIGHT = 60;
BOX_WALL_THICKNESS = 4;
BOX_CORNER_RADIUS = 8;
BOX_LID_CLEARANCE = fit_shell(0.5);
BOX_WALL_CLEARANCE = fit_clearance(0.4);

//=============================================================================
// PAN / TILT MECHANISMS
//=============================================================================
PAN_DIAMETER = 85;
PAN_CENTER_BORE = 28;
PAN_BEARING_OD = 22;
PAN_BEARING_ID = 8;
PAN_BEARING_WIDTH = 7;
PAN_SHAFT_CLEARANCE = fit_clearance(0.2);

TILT_PIVOT_DIAMETER = 12;
TILT_PIVOT_LENGTH = 35;
TILT_BEARING_OD = 22;
TILT_BEARING_ID = 8;
TILT_BEARING_WIDTH = 7;

//=============================================================================
// SLIP RING
//=============================================================================
SLIP_RING_DIAMETER = 22;
SLIP_RING_LENGTH = 35;
SLIP_RING_CLEARANCE = fit_clearance(0.35);

//=============================================================================
// CAMERA & SENSORS
//=============================================================================
CAMERA_MOUNT = "ESP32_CAM"; // ESP32_CAM, PI_CAM3, PI_AI, USB
CAMERA_MODULE_WIDTH = 40;
CAMERA_MODULE_HEIGHT = 32;
CAMERA_MODULE_DEPTH = 10;
CAMERA_MOUNTING_HOLE = 2.5;
CAMERA_MOUNTING_SPACING = 28;

COMPUTE_PLATFORM = "ESP32"; // ESP32, PI5
COMPUTE_BOARD_WIDTH = 54;
COMPUTE_BOARD_DEPTH = 40;
COMPUTE_BOARD_HEIGHT = 12;

//=============================================================================
// MICROPHONE
//=============================================================================
MIC_DIAMETER = 8.90;
MIC_LENGTH = 8.90;
MIC_CLAMP_CLEARANCE = fit_clearance(0.2);
MIC_HOLE_DIAMETER = fit_slip(MIC_DIAMETER);

//=============================================================================
// BATTERY & POWER
//=============================================================================
BATTERY_WIDTH = 70;
BATTERY_DEPTH = 45;
BATTERY_HEIGHT = 20;
BATTERY_CABLE_CLEARANCE = fit_clearance(5);

//=============================================================================
// IDENTITY & BADGING
//=============================================================================
BADGE_WIDTH = 40;
BADGE_HEIGHT = 15;
BADGE_DEPTH = 2;
BADGE_FILLET = 2;
BADGE_MOUNT_HOLE = 3.0;

//=============================================================================
// COLOR PALETTE
//=============================================================================
COLOR_PRINT = [0.10, 0.10, 0.10];
COLOR_HARDWARE = [0.75, 0.75, 0.75];
COLOR_ELECTRONICS = [0.00, 0.50, 0.10];
COLOR_MOTOR = [0.30, 0.30, 0.30];
COLOR_REFERENCE = [1.0, 0.0, 0.0];
