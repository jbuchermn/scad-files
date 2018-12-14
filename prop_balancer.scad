$fn = 100;

// Base plate
translate([-25, -25, 0]) cube([50, 50, 4]);

// Sides
module side(){
    union(){
        translate([-25, 0, 0]) cube([4, 4, 50]);
        translate([21, 0, 0]) cube([4, 4, 50]);
        difference(){
            translate([-25, 0, 0]) cube([50, 4, 50]);
            translate([0, 0, 110]) rotate([135, 0, 0]) cube([100, 100, 1000], center=true);
        }
    }
}

translate([0, -25, 0]) side();
translate([0, 25, 0]) rotate([0, 0, 180]) side();
