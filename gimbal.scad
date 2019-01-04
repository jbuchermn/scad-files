$fn = 100;

connector_width = 16.;
connector_triangle = 10.;

yaw_angle = 20;
tilt_angle = 0;
pitch_angle = 0;

yaw_balance = -15.;
tilt_balance = 8.;
pitch_balance = 4;

camera_offset = 4.;
tilt_motor_offset = 0.;
yaw_motor_offset = 4.;

assembled();

module assembled(){
    translate([0, 0, 40 + yaw_motor_offset]) rotate([0, 180, 45]) brushless(-yaw_angle);
    rotate([0, 0, yaw_angle]) translate([0, yaw_balance, 0]) {

        translate([0, 42.5 + tilt_motor_offset, 0]) rotate([90, -90, 0]) 
            connector(length = 19.5 + yaw_motor_offset, height = 42. + yaw_balance + tilt_motor_offset);

        translate([0, 40 + tilt_motor_offset, 0]) rotate([0, 90, -90]) rotate([0, 0, 90]) brushless(-tilt_angle);
        rotate([0, tilt_angle, 0])translate([tilt_balance, 0, 0]){

            translate([-28, 0, 0]) rotate([90, 0, 90]) 
                connector(length = 19.5 + tilt_motor_offset, height = 28. - tilt_balance);

            translate([-25, 0, 0]) rotate([0, 90, 0]) brushless(-pitch_angle);
            rotate([-pitch_angle, 0, 0]) 
                translate([3. + camera_offset, 8. + pitch_balance, 0.])
                rotate([90, 0, 0]){
                    pitch_connector();
                    runcam_split();
            }
        }
    }
}

module brushless(delta_angle){
    color([0.4, 0.4, 0.4]) rotate([0, 0, 45]) difference(){
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
    color([0.7, 0.7, 0.7]) rotate([0, 0, 45 + delta_angle]) difference(){
        translate([0, 0, 12. + 6.2]) rotate_extrude($fn = 360){
            polygon([[0, 0], [7, 0], [11.5, -5.], [11.5, -6.], [0, -6.]]);
        }

        translate([4.5, 0, 10]) cylinder(h = 100., r = 1.);
        translate([-4.5, 0, 10]) cylinder(h = 100., r = 1.);
        translate([0, 4.5, 10]) cylinder(h = 100., r = 1.);
        translate([0, -4.5, 10]) cylinder(h = 100., r = 1.);
    }
}

module runcam_split(){
    difference(){
        union(){
            color([0.8, 0.2, 0.]) translate([-9.5, -9.5, 0]) cube([19, 19, 10]);
            color([0.2, 0.2, 0.2]) cylinder(r = 7., h = 21.);
        }
        translate([-50, 0, 8]) rotate([0, 90, 0]) cylinder(h = 100., r = 1.);
    }
}

translate([38, 28, 18]) runcam_split_board();

module runcam_split_board(){
    smooth_rad = 2.;
    color([0.1, 0.1, 0.7]) linear_extrude(height = 7.){
        difference(){
            minkowski(){
                square([38. - smooth_rad, 38. - smooth_rad], center=true);
                circle(r = smooth_rad);
            }

            translate([15.5, 15.5]) circle(r = 2.);
            translate([15.5, -15.5]) circle(r = 2.);
            translate([-15.5, 15.5]) circle(r = 2.);
            translate([-15.5, -15.5]) circle(r = 2.);
        }
    }
}

module pitch_connector(){
    translate([0, 0, 5]) difference(){
        translate([-14, -12, -5]) cube([26, 24, 10]);
        translate([-10, -10, -50]) cube([20, 20, 100]);
        translate([0, 0, 3]) rotate([0, 90, 0]) cylinder(r=1., h=100.);
    }

    translate([-14., 0., 8. + pitch_balance]) rotate([0, 90, 0]) difference(){
        cylinder(r = 8., h = 3.);

        tmp = 4.5*sin(45);
        translate([tmp, tmp, -10]) cylinder(r = 1.2, h = 20.);
        translate([tmp, -tmp, -10]) cylinder(r = 1.2, h = 20.);
        translate([-tmp, tmp, -10]) cylinder(r = 1.2, h = 20.);
        translate([-tmp, -tmp, -10]) cylinder(r = 1.2, h = 20.);
    }
}


module connector(length, height){
    difference(){
        union(){
            difference(){
                union(){
                    cylinder(r = 12, h = 2.);
                    translate([0, -connector_width/2., 0]) cube([length, connector_width, 2]);
                }

                tmp1 = 8*sin(45);
                tmp2 = 6*sin(45);
                translate([tmp1, tmp1, -10]) cylinder(r = 1.2, h = 20.);
                translate([tmp2, -tmp2, -10]) cylinder(r = 1.2, h = 20.);
                translate([-tmp2, tmp2, -10]) cylinder(r = 1.2, h = 20.);
                translate([-tmp1, -tmp1, -10]) cylinder(r = 1.2, h = 20.);

            }
            translate([length, 0, height]) rotate([0, 90, 0]) {
                difference(){
                    union(){
                        cylinder(r = 8, h = 2);
                        translate([0, -connector_width/2., 0])cube([height, connector_width, 2]);
                    }

                    tmp = 4.5*sin(45);
                    translate([tmp, tmp, -10]) cylinder(r = 1.2, h = 20.);
                    translate([tmp, -tmp, -10]) cylinder(r = 1.2, h = 20.);
                    translate([-tmp, tmp, -10]) cylinder(r = 1.2, h = 20.);
                    translate([-tmp, -tmp, -10]) cylinder(r = 1.2, h = 20.);
                }
            }
            translate([length, -connector_width/2., 0.]) 
                rotate([90, 0, 180]) 
                linear_extrude(height = connector_width){
                    polygon([[0, 0], [connector_triangle, 0], [0, connector_triangle]]);
            }
        }
        translate([0, 0, -50]) cylinder(h = 100., r = 1.5);
        translate([0, 0, 3.5/2. + 2.]) cube([100., 5.5, 3.5], center=true);
    }
}
