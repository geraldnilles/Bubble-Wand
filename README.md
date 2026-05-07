# Bubble Wand

A custom-designed, 3D-printable bubble wand and storage rack, built with [OpenSCAD](https://openscad.org/) and the [BOSL2](https://github.com/BelfrySCAD/BOSL2) library.

Designed by a dad for his daughters and their friends — because bubble wands should be *indestructible* and custom-fit for tiny hands.

---

## Wands

The wand consists of two printed parts:

| Part | Description |
|------|-------------|
| **Ring** | A thick, toothed bubble loop that holds the bubble film. The serrated edges help retain more bubble solution for bigger, stronger bubbles. |
| **Handle** | A long, slim rod that fits small hands comfortably. |

![Printed bubble wand being held](assets/circle_wand.jpg)

Both parts are printed separately and glued together with superglue (CA glue). The handle adapter on the ring creates a strong mechanical bond.

### Ring Shapes

The wand supports **two ring profiles**, controlled by commenting/uncommenting the `radius()` function in `Bubble_Wand.scad`:

| Shape | Code |
|-------|------|
| **Circular (default)** | `function radius(r,angle) = r;` |
| **Oval** | `function radius(r,angle) = ((0.5*sin(angle))^2+0.75)*r;` |

Simply uncomment your preferred line and comment the other, then re-render.

![Circular ring render](assets/ring.png)     ![Oval ring render](assets/oval.png)

### Printing Instructions

**Step 1 — Render the ring with its handle adapter:**
```openscad
ring();
handle_adapter();
// handle(x=8);          // <-- keep commented
```

**Step 2 — Render the handle separately:**
```openscad
// ring();
// handle_adapter();
handle(x=8);
```

**Step 3 — Glue.** Apply superglue to the handle adapter (the small rectangular nub on the ring) and insert it into the matching hole on the handle. Hold for 30 seconds.

### Parameters

All adjustable values are at the top of `Bubble_Wand.scad`:

| Variable | Default | Description |
|----------|---------|-------------|
| `ring_radius` | `70` | Radius of the bubble ring |
| `ring_thickness` | `10` | Thickness (depth) of the ring's teeth |
| `slot_width` | `1.2` | Width of each tooth/gap |
| `slot_height` | `1.2` | Height of the tooth profile |

---

## Wand Rack / Mount

The [Wand_rack_mount.scad](./Wand_rack_mount.scad) file generates a clamp-on bracket that mounts to the edge of a surface (e.g., a bubble table, plastic stool, or bench). It securely stores up to two wands by their handles.

![Wand rack in use](assets/wand_rack.jpg)

Key features:
- **Funnel-shaped slot opening** — wands slide in easily but stay put.
- **Reinforced mounting flanges** with countersunk screw holes.
- **Adjustable parameters** — resize the slot width, funnel taper, screw holes, and flange dimensions to fit your table edge.

---

## Bubble Solution

> 📖 See the [Bubble Solution Recipe](./Bubble_Solution.md) for the homemade bubble mix that makes these wands really shine.

---

## License

This project is open source under the [MIT License](LICENSE). Print, modify, and share freely!
