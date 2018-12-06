$fn = 100;

// Base plate
translate([-25, -25, 0]) cube([50, 50, 4]);

// Sides
module side(){
    difference(){
        translate([-25, 0, 0]) cube([50, 4, 50]);
        translate([0, 0, 140]) rotate([100, 0, 0]) cylinder(h=1000, r=100, center=true);
    }
}

translate([0, -25, 0]) side();
translate([0, 25, 0]) rotate([0, 0, 180]) side();
