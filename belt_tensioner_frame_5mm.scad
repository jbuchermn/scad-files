$fn = 100;
slim_by_half = 1.5;

difference(){
    slim_frame();
    translate([0, 0, 3.6]) rotate([0, 90, 0]) cylinder(r=1.7, h=10);
    translate([0, 0, 24.1]) rotate([0, 90, 0]) cylinder(r=1.7, h=10);
}

module slim_frame(){
    part1();
    part2();
}

module part1(){
    translate([0, -slim_by_half, 0])
        intersection(){
            frame();
            translate([0, slim_by_half, 0]) cube([100, 100, 100]);
        }
}

module part2(){
    translate([0, slim_by_half, 0])
        intersection(){
            frame();
            translate([0, -100 - slim_by_half, 0]) cube([100, 100, 100]);
        }
}

module frame(){
    translate([-5, -31, -3.5]) import("belt_tensioner_frame_8mm.stl");
}
