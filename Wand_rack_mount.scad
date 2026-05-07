
include <BOSL2/std.scad>

// --- Parameters ---
// Main Body Dimensions
body_w = 120;
body_d = 30;
body_h = 15;

// Slot Dimensions
slot_w = 100;
slot_d = 10;
funnel_w = 3; // NEW: How much wider the top opening is
funnel_h = 3; // NEW: How deep the funnel goes into the slot

// Flange Dimensions
flange_w = 20;    
flange_th = 5;    
gusset_drop = 15; 

// Screw Hole Dimensions
screw_d = 4.5;    
head_d = 8.5;     
head_h = 2.5;     
screw_margin = 6; 

// --- Model ---
difference() {
    union() {
        // 1. Main Body
        cuboid([body_w, body_d, body_h], rounding=2);
        
        // 2. Reinforced Mounting Flanges (Left and Right)
        for (dir = [-1, 1]) {
            hull() {
                // Outer boss
                translate([dir * (body_w/2 + flange_w - screw_margin), body_d/2 - flange_th/2, 0])
                    cuboid([screw_margin * 2, flange_th, body_h], rounding=2);
                
                // Inner base
                translate([dir * (body_w/2 - 1), body_d/2 - (flange_th + gusset_drop)/2, 0])
                    cuboid([4, flange_th + gusset_drop, body_h], rounding=2); 
            }
        }
    }
    
    // 3. Inner Slot & Funnel
    // Main vertical slot through the body
    cuboid([slot_w, slot_d, body_h + 2], rounding=1);
    
    // Top Funnel Chamfer
    // Shifted slightly above the surface (+0.01) to prevent rendering artifacts
    up(body_h/2 + 0.01)
        prismoid(
            size1 = [slot_w, slot_d], 
            size2 = [slot_w + funnel_w*2, slot_d + funnel_w*2], 
            h = funnel_h, 
            rounding = 1, // Matches the rounding of the main slot
            anchor = TOP  // Ensures the wide part stays locked to the top surface
        );
    
    // 4. Countersunk Screw Holes
    for (dir = [-1, 1]) {
        translate([dir * (body_w/2 + flange_w - screw_margin), body_d/2 - flange_th/2, 0])
            xrot(90) { 
                
                // Main through-hole 
                cyl(d=screw_d, l=50);
                
                // Countersink
                up(flange_th/2 + 0.01) 
                    cyl(d1=screw_d, d2=head_d, l=head_h, anchor=TOP);
                
                // Clearance shaft 
                up(flange_th/2)
                    cyl(d=head_d, l=20, anchor=BOTTOM);
            }
    }
}

