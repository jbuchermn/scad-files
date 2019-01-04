$fn = 100;

height = 100;
delta = 4.5;
distance = 145;
strength = 6;
width = distance - 2*delta;
socket_height = 15;
outer_radius = 6;
inner_radius = 1.5;
smooth_radius = 25;

translate([0, delta, 0]) skid();
translate([0, 0, outer_radius]) rotate([0, 90, 0]) socket();
translate([socket_height, distance, outer_radius]) rotate([0, 90, 180]) socket();

module skid(){
    linear_extrude(height = strength){
        intersection(){
            square([height, width]);
            difference(){
                translate([0, smooth_radius])
                    minkowski(){
                        square([height - smooth_radius, width - 2*smooth_radius]);
                        circle(smooth_radius);
                    }
                translate([0, smooth_radius + strength])
                    minkowski(){
                        square([height - strength - smooth_radius, width - 2*strength - 2*smooth_radius]);
                        circle(smooth_radius);
                    }
            }
        }
    }
}

module socket(){
    linear_extrude(height = socket_height){
        difference(){
            union(){
                circle(outer_radius);
                square([outer_radius, outer_radius]);
            }
            circle(inner_radius);
        }
    }
}
