$fn = 100;

gopro_extent = 20;

base_length = 50;
skid_length = 36;
base_width = 50;
skid_width = 5;
base_height = 4;
skid_height = 8;

strength_mount = 4;
strength_dampers = 1.5;


//translate([10, base_width/2. - 7.5, base_height + gopro_extent]) rotate([0, 90, 90]) gopro_mount();
//base_plate();
skid();
//translate([0, base_width - skid_width]) skid();


module gopro_mount(){
    translate([0, 0, 0]) mount_element();
    translate([0, 0, 6]) mount_element();
    translate([0, 0, 12]) mount_element();
}

module mount_element(){
    linear_extrude(height=3){
        difference(){
            union(){
                circle(15/2.);
                translate([0, -7.5]) square([gopro_extent, 15]);
            }
            teardrop(5.4/2.);
            //circle(5.4/2.);
        }
    }
}

module teardrop(radius){
    union(){
        circle(radius);
        polygon(points=[[-.5*radius, -.8*radius], [-.5*radius, .8*radius], [-1.3*radius, 0.]]);
    }
}

module base_plate(){
    difference(){
        cube([base_length, base_width, base_height]);
        translate([4, skid_width, -base_height]) cube([base_length - 8, 4, 3*base_height]);
        translate([4, base_width - skid_width - 4, -base_height]) cube([base_length - 8, 4, 3*base_height]);
    }
}

module skid(){
    translate([base_length - skid_length, 0, -strength_mount])
        cube([skid_length, skid_width, strength_mount]);
    translate([base_length - skid_length, 0, -strength_mount - skid_height])
        cube([strength_dampers, skid_width, skid_height]);
    translate([base_length - strength_dampers, 0, -strength_mount - skid_height])
        cube([strength_dampers, skid_width, skid_height]);
    translate([base_length - .5*skid_length - .5*strength_dampers, 0, -strength_mount - skid_height])
        cube([strength_dampers, skid_width, skid_height]);
    translate([base_length - skid_length, 0, -2.*strength_mount - skid_height])
        cube([skid_length, skid_width, strength_mount]);
}
