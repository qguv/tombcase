$fn=100;

//tolerance = 0.2;
fudge = 0.01;

module tombstone(x, y, z, r, extra_base=0) {
    hull() {

        // bottom left rounded corner
        translate([
            r,
            r,
            0
        ]) cylinder(
            h=z + extra_base,
            r=r
        );

        // bottom right rounded corner
        translate([
            x - r,
            r,
            0
        ]) cylinder(
            h=z + extra_base,
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

module case(
    width,
    height,
    depth,
    border_radius,
    wall,
    play,
    extra_base = 0
) {
    inner_width = play + width + play;
    inner_height = height;
    inner_depth = play + depth + play;
    inner_border_radius = play + border_radius;

    outer_width = wall + inner_width + wall;
    outer_height = wall + inner_height;
    outer_depth = wall + inner_depth + wall;
    outer_border_radius = inner_border_radius + wall;

    difference() {

        // outer
        tombstone(
            outer_width,
            outer_height,
            outer_depth,
            outer_border_radius,
            extra_base=extra_base
        );

        // inner
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

        // punch
        translate([
            outer_width / 2,
            0,
            -fudge
        ]) cylinder(
            h=fudge + outer_depth + extra_base + fudge,
            d=outer_width / 4
        );
    }
}

module aleve6() {
    case(
        width = 52,
        height = 53,
        depth = 4,
        border_radius = 5,
        wall = 1.25,
        play = 0.5
    );
}

module aleve12() {
    case(
        width = 52,
        height = 106,
        depth = 4,
        border_radius = 5,
        wall = 1.25,
        play = 0.5
    );
}

module dia10() {
    case(
        width = 35,
        height = 86,
        depth = 4.8,
        border_radius = 5,
        wall = 1.25,
        play = 0.5
    );
}

module all() {
    rotate([0, 0, 180]) {
        aleve6();
        translate([60, 0, 0]) aleve12();
        translate([120, 0, 0]) dia10();
    }
}

all();
