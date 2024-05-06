$fn=100;

tolerance = 0.15;
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
    extra_base = 0
) {
    inner_width = tolerance + width + tolerance;
    inner_height = height;
    inner_depth = tolerance + depth + tolerance;
    inner_border_radius = tolerance + border_radius;

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

module _aleve(height) {
    case(
        width = 52.7,
        height = height,
        depth = 5.2,
        border_radius = 5,
        wall = 1.25
    );
}

module aleve6() {
    _aleve(53);
}

module aleve12() {
    _aleve(106);
}

module dia10() {
    case(
        width = 35.0,
        height = 85.8,
        depth = 4.8,
        border_radius = 5,
        wall = 1.25
    );
}

module dex10() {
    case(
        width = 34.7,
        height = 84.2,
        depth = 4.6,
        border_radius = 5,
        wall = 1.25
    );
}

// count in [2, 4, 6, 8, 10]
module etos_nap(count) {
    edge_pairs = (count == 10) ? 2 : 1;
    middle_pairs = floor(count / 2) - edge_pairs;
    case(
        width = 41.0,
        height = edge_pairs * 22.5 + middle_pairs * 21.5,
        depth = 6.3,
        border_radius = 5,
        wall = 1.25
    );
}

module all() {
    rotate([0, 0, 180]) {
        translate([60*0, 0, 0]) aleve6();
        translate([60*1, 0, 0]) aleve12();
        translate([60*2, 0, 0]) dia10();
        translate([60*3, 0, 0]) dex10();
        translate([60*4, 0, 0]) etos_nap(4);
        translate([60*5, 0, 0]) etos_nap(10);
    }
}

all();
