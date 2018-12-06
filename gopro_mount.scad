$fn = 100;

gopro_extent = 15;

mount_length = 36;
mount_width = 50;
mount_strength = 4;
mount_height = 10;


translate([10, mount_width/2. - 7.5, mount_height + gopro_extent]) rotate([0, 90, 90]) gopro_mount();
frame_mount();

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
            circle(5.4/2.);
        }
    }
}

module frame_mount(){
    translate([0, 0, mount_height]) cube([mount_length, mount_width, mount_strength]);
    skid();
    translate([0, mount_width - mount_strength, 0]) skid();
}

module skid(){
    cube([mount_length, mount_strength, mount_strength]);
    cube([mount_strength, mount_strength, mount_height]);
    translate([mount_length/2. - mount_strength/2., 0, 0]) cube([mount_strength, mount_strength, mount_height]);
    translate([mount_length - mount_strength, 0, 0]) cube([mount_strength, mount_strength, mount_height]);
}
