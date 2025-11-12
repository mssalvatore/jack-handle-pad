include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=256;


od=47;
id=33.5; // Measured 33.4
wall_thickness = (od - id) / 2;

slotted_section_z = 125;
solid_section_z = 180;

button_pin_diameter = 6.3; // Measured 5.8
button_pin_slot_z = 35;
button_pin_slot_y_pos = id / 2 + (wall_thickness / 2);
button_pin_slot_z_pos = 74.75; // Measured 75.75

module pad(height) {
            tube(height, id=id, od=od, align=V_TOP);
}

module slot() {
            cuboid(
                [button_pin_diameter, wall_thickness * 3, button_pin_slot_z],
                fillet=button_pin_diameter / 2,
                align=V_TOP
            );
}
module jack_handle_pad(include_slot, height) {
    if (include_slot) {
        difference() {
            pad(height);
            move([0, button_pin_slot_y_pos, button_pin_slot_z_pos]) {
                slot();
            }
        }
    }
    else {
        pad(height);
    }
}


// UNCOMMENT TO RENDER BOTH SECTIONS TOGETHER
/*
distribute(spacing = od * 1.5) {
    jack_handle_pad(include_slot=true, height=slotted_section_z);
    jack_handle_pad(include_slot=false, height=solid_section_z);
}
*/

// UNCOMMENT INDIVIDUALLY TO RENDER SEPARATE PARTS
jack_handle_pad(include_slot=true, height=slotted_section_z);
//jack_handle_pad(include_slot=false, height=solid_section_z);
