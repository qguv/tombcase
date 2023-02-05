$fn=100;

width = 52;
height = 53; // 106
depth = 4;
border_radius = 5;

play = 0.5;
wall = 1.25;

//tolerance = 0.2;
fudge = 0.01;

inner_width = play + width + play;
inner_height = play + height + play;
inner_depth = play + depth + play;
inner_border_radius = play + border_radius;

outer_width = wall + inner_width + wall;
outer_height = wall + inner_height;
outer_depth = wall + inner_depth + wall;
outer_border_radius = inner_border_radius + wall;

module tombstone(x, y, z, r) {
    hull() {

        // bottom left rounded corner
        translate([
            r,
            r,
            0
        ]) cylinder(
            h=z,
            r=r
        );

        // bottom right rounded corner
        translate([
            x - r,
            r,
            0
        ]) cylinder(
            h=z,
            r=r
        );

        // top face
        translate([
            0,
            y - fudge,
            0
        ]) cube([
            x,
            fudge,
            z
        ]);
    }
}

module outer() {
    tombstone(
        outer_width,
        outer_height,
        outer_depth,
        outer_border_radius
    );
}

module inner() {
    translate([
        wall,
        wall,
        wall
    ]) tombstone(
        inner_width,
        inner_height + fudge,
        inner_depth,
        inner_border_radius
    );
}

module punch() {
    translate([
        outer_width / 2,
        0,
        -fudge
    ]) cylinder(
        h=fudge + outer_depth + fudge,
        d=outer_width / 4
    );
}

module case() {
    difference() {
        outer();
        inner();
        punch();
    }
}

module all() {
    rotate([0, 0, 180]) {
        case();
    }
}

all();
