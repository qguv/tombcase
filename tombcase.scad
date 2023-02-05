$fn=100;

width = 52;
height = 53; // 106
depth = 4;
border_radius = 5;

play = 0.5;
wall = 1.5;
tolerance = 0.2;
fudge = 0.01;

module slab(x, y, z, r) {
    hull() {
        for (i = [0:1]) {
            for (j = [0:1]) {
                translate([
                    i * (x - 2 * r),
                    j * (y - 2 * r),
                    0,
                ])
                translate([r, r, 0])
                    cylinder(
                        h=z,
                        r=r
                    );
            }
        }
    }
}

module case() {
    difference() {
        slab(
            wall + play + width + play + wall,
            wall + play + height + border_radius + play + wall,
            wall + play + depth + play + wall,
            border_radius + wall
        );

        translate([
            wall,
            wall,
            wall
        ]) slab(
            play + width + play,
            play + height + border_radius + play,
            play + depth + play,
            border_radius
        );

        translate([
            -fudge,
            wall + play + height + play,
            -fudge
        ]) cube([
            fudge + wall + play + width + play + wall + fudge,
            border_radius + wall + fudge,
            fudge + wall + play + depth + play + wall + fudge
        ]);

        translate([
            (wall + play + width + play + wall) / 2,
            0,
            -fudge
        ]) cylinder(
            h=fudge + wall + play + depth + play + wall + fudge,
            d=(wall + play + width + play + wall) / 4
        );
    }
}

module all() {
    rotate([0, 0, 180]) {
        case();
    }
}

all();
