$fa = $preview ? 3 : 0.4;
$fs = $preview ? 6 : 0.8;

og_liner();
badges();

badge_spacing = 5.4375;
badge_thickness = 0.4;
badges_x=32;
badges_y=18;
matrix_x=badge_spacing*(badges_x-1);
matrix_y=badge_spacing*(badges_y-1);

module og_liner() {
    import("/Users/joshlewis/code/chargian/OpenSourceEvMagsafeLiner.stl");
}

module badges() {
  translate([0,0,badge_thickness*1.5625])
  intersection() {
    og_liner();
    translate([0,0,-badge_thickness])
    badge_matrix();
  }
}
module badge_small() {
    linear_extrude(badge_thickness)
    import("/Users/joshlewis/code/chargian/rivian-badge.svg", center = true, dpi = 222.25);
}

module badge_matrix() {
  translate([-matrix_x/2, -matrix_y/2,0])
  union() {
    badge_grid(badges_x, badges_y);
    translate([badge_spacing/2, badge_spacing/2,0])
    badge_grid(badges_x-1, badges_y-1);
  }
}
module badge_grid(nx,ny) {
  for (y=[0:badge_spacing:badge_spacing*(ny-1)]) {
    translate([0,y,0])
    badge_row(nx);
  }
}

module badge_row(nx) {
  for (x=[0:badge_spacing:badge_spacing*(nx-1)]) {
    translate([x,0,0])
    badge_small();
  }
}