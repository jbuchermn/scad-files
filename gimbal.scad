$fn = 100;

yaw_angle = 00;
tilt_angle = 0;
pitch_angle = 0;

translate([0, 0, 50]) rotate([0, 180, 0]) brushless(-yaw_angle);
rotate([0, 0, yaw_angle]){
    translate([0, 35, 0]) rotate([0, 90, -90]) brushless(-tilt_angle);
    rotate([0, tilt_angle, 0]){
        translate([-25, 0, 0]) rotate([0, 90, 0]) brushless(-pitch_angle);
        rotate([-pitch_angle, 0, 0]) cube([10, 5, 10], center=true);
    }
}

module brushless(delta_angle){
    rotate([0, 0, 45]) difference(){
        union(){
            cylinder(r = 11.5, h = 12.);
            translate([0, 0, -1.5]) cylinder(r = 1., h = 1.5);
            rotate([0, 0, -45]) translate([-2.5, 0, 0]) cube([5, 20, 3]);
        }

        translate([-6, 0, -99]) cylinder(h = 100., r = 1.);
        translate([6, 0, -99]) cylinder(h = 100., r = 1.);
        translate([0, 8, -99]) cylinder(h = 100., r = 1.);
        translate([0, -8, -99]) cylinder(h = 100., r = 1.);
    }
    rotate([0, 0, 45 + delta_angle]) difference(){
        translate([0, 0, 12. + 6.2]) rotate_extrude($fn = 360){
            polygon([[0, 0], [7, 0], [11.5, -5.], [11.5, -6.], [0, -6.]]);
        }

        translate([4.5, 0, 10]) cylinder(h = 100., r = 1.);
        translate([-4.5, 0, 10]) cylinder(h = 100., r = 1.);
        translate([0, 4.5, 10]) cylinder(h = 100., r = 1.);
        translate([0, -4.5, 10]) cylinder(h = 100., r = 1.);
    }
}
