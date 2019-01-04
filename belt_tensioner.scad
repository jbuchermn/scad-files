$fn = 100;

distance_center = 10;
height_center = 2;
height_arm = 42;

height_socket = 15;
width_arm = 2;
width_socket = 20;
length_socket = 20;

screw_head_height = 2.;
inner_radius = 1.5;
outer_radius = 4;

minkowski_radius = 3.;


socket();
translate([-distance_center/2. - width_arm/2., 0, 0]) arm();
translate([distance_center/2. + width_arm/2., 0, 0]) arm();

module socket(){
    width = 2*width_socket + 2*width_arm + distance_center;
    length = length_socket;

    difference(){
        linear_extrude(height = height_socket){
            minkowski(){
                polygon([
                    [-width/2. + minkowski_radius, -length/2. + minkowski_radius],
                    [-width/2. + minkowski_radius, length/2. - minkowski_radius],
                    [width/2. - minkowski_radius, length/2. - minkowski_radius],
                    [width/2. - minkowski_radius, -length/2. + minkowski_radius]
                ]);
                circle(minkowski_radius);
            }
        }

        // translate([-distance_center/2. - width/4., -length/4., 0.]) cylinder(r=inner_radius, h=1000);
        // translate([-distance_center/2. - width/4., length/4., 0.]) cylinder(r=inner_radius, h=1000);
        // translate([distance_center/2. + width/4., -length/4., 0.]) cylinder(r=inner_radius, h=1000);
        // translate([distance_center/2. + width/4., length/4., 0.]) cylinder(r=inner_radius, h=1000);

        // translate([-distance_center/2. - width/4., -length/4., height_socket - screw_head_height]) 
        //     cylinder(r=outer_radius, h=1000);
        // translate([-distance_center/2. - width/4., length/4., height_socket - screw_head_height])
        //     cylinder(r=outer_radius, h=1000);
        // translate([distance_center/2. + width/4., -length/4., height_socket - screw_head_height])
        //     cylinder(r=outer_radius, h=1000);
        // translate([distance_center/2. + width/4., length/4., height_socket - screw_head_height])
        //     cylinder(r=outer_radius, h=1000);

        translate([-distance_center/2. - width/4., 0., 0.]) cylinder(r=inner_radius, h=1000);
        translate([distance_center/2. + width/4., 0., 0.]) cylinder(r=inner_radius, h=1000);

        translate([-distance_center/2. - width/4., 0., height_socket - screw_head_height])
            cylinder(r=outer_radius, h=1000);
        translate([distance_center/2. + width/4., 0., height_socket - screw_head_height])
            cylinder(r=outer_radius, h=1000);

        translate([-distance_center/2., -500, height_center]) cube([distance_center, 1000, 1000]);
    }
}

module arm(){
    y1 = length_socket/3.;
    y2 = 2.*length_socket/3.;
    translate([-width_arm/2., -length_socket/2., 0]) difference(){
        cube([width_arm, length_socket, height_arm]);
        translate([-500, y1, 20.]) rotate([0, 90, 0]) cylinder(r=2, h=1000);
        translate([-500, y2, 24.]) rotate([0, 90, 0]) cylinder(r=2, h=1000);
        translate([-500, y1, 28.]) rotate([0, 90, 0]) cylinder(r=2, h=1000);
        translate([-500, y2, 32.]) rotate([0, 90, 0]) cylinder(r=2, h=1000);
        translate([-500, y1, 36.]) rotate([0, 90, 0]) cylinder(r=2, h=1000);
    }
}
