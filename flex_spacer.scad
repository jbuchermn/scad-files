width = 16;
height = 12;
depth = 5;
strength = 2;

difference(){
    cube([width, height, depth], center=true);
    cube([width - strength*2, height - strength*2, depth*2], center=true);
}

