$fn=20;

screw_head_r = 4.4;
screw_head_h = 3;
screw_r = 2.25;

spacer_h = 20;

pegboard_h = 5;
pegboard_rows = 4;
pegboard_cols = 4;

pegboard_x = pegboard_cols * 40 + 20;
pegboard_y = pegboard_rows * 40 + 20; 

skadis();

module fillet() {
    difference() {
        square([pegboard_h,2]);
        translate([1,0,0]) hull() {
            circle(1);
            translate([pegboard_h - 2,0,0]) circle(1);
        }
    }    
}

module skadis() {
    difference() {
        cube([pegboard_x, pegboard_y ,pegboard_h]);

        for(r = [0:pegboard_rows - 1])
            for(i = [0 : pegboard_cols - 1])
               translate([i*40 + 20, 40*r + 20, 0]) hole();

        for(r = [0:pegboard_rows - 1])
            for(i = [0 : pegboard_cols - 1])
               translate([i*40 + 40, 40*r + 40, 0]) hole();
            
        *for(r = [0:pegboard_rows - 1])
            for(i = [0 : pegboard_cols - 1])
               translate([i*40 + 32.5, 40*r + 12.5, -1]) cube([15,15,10]);

        *for(r = [0:pegboard_rows - 1])
            for(i = [0 : pegboard_cols - 1])
               translate([i*40 + 12.5, 40*r + 32.5, -1]) cube([15,15,10]);

        translate([10,10,-1]) cylinder(pegboard_h + spacer_h + 2, 5, 5);
        translate([pegboard_x - 10,10,-1]) cylinder(pegboard_h + spacer_h + 2, 5, 5);
        translate([10, pegboard_y - 10,-1]) cylinder(pegboard_h + spacer_h + 2, 5, 5);
        translate([pegboard_x - 10, pegboard_y - 10,-1]) cylinder(pegboard_h + spacer_h + 2, 5, 5);
    }
    
    translate([10,10,0]) spacer();
    translate([pegboard_x - 10,10,0]) spacer();
    translate([10, pegboard_y - 10,0]) spacer();
    translate([pegboard_x - 10, pegboard_y - 10,0]) spacer();
}

module spacer() {
    difference() {
        cylinder(pegboard_h + spacer_h,5,5);
        translate([0,0,-1]) cylinder(pegboard_h + spacer_h + 2,screw_r,screw_r);
        cylinder(screw_head_h,screw_head_r,screw_r);
    }
}

module hole() {
    w = 5;
    translate([0,-5,-1])
    union() {
        cylinder(pegboard_h+3,w/2,w/2);
        translate([-2.5,0,0]) cube([5,10,pegboard_h+2]);
        translate([0,10,0]) cylinder(pegboard_h+3,w/2,w/2);
    }
    
    translate([0,0,-1]) hole_fillet();
    translate([0,0,pegboard_h + 1]) rotate([180,0,0]) hole_fillet();
}

module hole_fillet() {
    translate([0,-5,pegboard_h])
        rotate_extrude(angle=366)
            translate([-3.5,0]) difference() {
                square([2,2]);
                circle(1);
            }

    translate([0,5,pegboard_h])
        rotate_extrude(angle=-360)
            translate([-3.5,0]) difference() {
                square([2,2]);
                circle(1);
            }
            
    translate([-0.5,5,pegboard_h])
        rotate([90,0,0])
            linear_extrude(10)
                translate([-3,0]) difference() {
                    square([2,2]);
                    circle(1);
                }

    translate([3.5,5,pegboard_h+3])
        rotate([0,-90,0]) rotate([90,0,0])
            linear_extrude(10)
                translate([-3,0]) difference() {
                    square([2,2]);
                    circle(1);
                }

}