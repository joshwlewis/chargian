$fa = $preview ? 2 : 0.4;
$fs = $preview ? 4 : 0.4;

shelf_shell();

module shelf() {
    difference() {
        og_shelf();
        badges();
        slip_clearances();
        mount_block();
    }
    covers();
}

module shelf_shell() {
    difference() {
        cube([200,200,200], center=true);
        difference() {
            cube([200,200,200], center=true);
            shelf();
        }
    }
}

module slip_clearances() {
    translate([43,0,0])
        slip_clearance();
    translate([-43,0,0])
        slip_clearance();
}

module slip_clearance() {
    translate([0,4.68,-10.6])
        rotate_extrude(360)
        polygon([[28,0],[27.4,3],[24,7.5],[0,7.5],[0,0]]);
}

module covers() {
    translate([43,0,0])
        cover();
    translate([-43,0,0])
        cover();
}
module cover() {
    difference() {
        translate([0,4.4,-16.2])
            linear_extrude(0.4)
            circle(30);
        translate([0,4.4,-16.2])
            badge_large();
    }
}

module og_shelf() {
    import("OpenSourceEvMagsafeShelf.stl");
}

module badge_large() {
    linear_extrude(.6)
        import("rivian-badge.svg", center = true, dpi = 41.275);
}

module badge_small() {
    linear_extrude(.4)
        import("rivian-badge.svg", center = true, dpi = 222.25);
}

badge_spacing=5.4375;
badges_x=32;
badges_y=14;
mat_width=badge_spacing*(badges_x-1);
mat_height=badge_spacing*(badges_y-1);
mat_chamfer=badge_spacing*0.34375;

module badges() {
    translate([0,-mat_height/2-8.2,-16.201])
        difference() {
            translate([-mat_width/2, -mat_height/2,0])
                linear_extrude(.4)
                polygon([
                        [mat_chamfer,0],
                        [mat_width-mat_chamfer,0],
                        [mat_width,mat_chamfer],
                        [mat_width,mat_height-mat_chamfer],
                        [mat_width-mat_chamfer,mat_height],
                        [mat_chamfer,mat_height],
                        [0,mat_height-mat_chamfer],
                        [0,mat_chamfer]
                ]);
            badge_matrix();
        };
}

module badge_matrix() {
    translate([(-mat_width/2)+(0*badge_spacing),(-mat_height/2)+(0*badge_spacing),0])
        badge_grid(badges_x,badges_y);
    translate([(-mat_width/2)+(.5*badge_spacing),(-mat_height/2)+(.5*badge_spacing),0])
        badge_grid(badges_x-1,badges_y-1);
}

module badge_grid(nx,ny) {
    for (dy=[0:badge_spacing:badge_spacing*(ny-1)]) {
        translate([0,dy,0])
            badge_row(nx);
    }
}

module badge_row(n) {
    for (dx=[0:badge_spacing:badge_spacing*(n-1)]) {
        translate([dx,0,0])
            badge_small();
    }
}

module mount_block() {
    translate([0,0,-10.3])
        linear_extrude(30)
        polygon([[50,-9.7],[86.28,-9.7],[86.28,-65],[50,-65]]);

}
