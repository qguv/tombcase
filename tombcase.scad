/* [Dimensions] */
Width = 34.7;
Height = 84.2;
Depth = 4.6;
Border_radius = 5;
Extra_base = 0;

/* [Advanced] */
$fn=100;
Tolerance = 0.15;
Punch = 0.01;
Wall = 1.25;

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
            y - Punch,
            0
        ]) cube([
            x,
            Punch,
            z
        ]);
    }
}

module case(
    width = Width,
    height = Height,
    depth = Depth,
    border_radius = Border_radius,
    extra_base = Extra_base
) {
    inner_width = Tolerance + width + Tolerance;
    inner_height = height;
    inner_depth = Tolerance + depth + Tolerance;
    inner_border_radius = Tolerance + border_radius;

    outer_width = Wall + inner_width + Wall;
    outer_height = Wall + inner_height;
    outer_depth = Wall + inner_depth + Wall;
    outer_border_radius = inner_border_radius + Wall;

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
            Wall,
            Wall,
            Wall
        ]) tombstone(
            inner_width,
            inner_height + Punch,
            inner_depth,
            inner_border_radius
        );

        // punch
        translate([
            outer_width / 2,
            0,
            -Punch
        ]) cylinder(
            h=Punch + outer_depth + extra_base + Punch,
            d=outer_width / 4
        );
    }
}

// count in [2, 4, 6, 8, 10]
function etos_nap_height(count) = let (
    edge_pairs = (count == 10) ? 2 : 1,
    middle_pairs = floor(count / 2) - edge_pairs
) edge_pairs * 22.5 + middle_pairs * 21.5;

module all() {
    case();
}

all();
