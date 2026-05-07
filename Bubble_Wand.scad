$fn = 50;
slot_width = 1.2;
slot_height = 1.2;
ring_thickness = 10;
ring_depth = slot_width;
step_angle = 4;

ring_radius = 70;

/***************************/
/* Oval Wand               */
/***************************/
//function radius(r,angle) = ((0.5*sin(angle))^2+0.75)*r;

/***************************/
/* Cicular Wand            */
/***************************/
function radius(r,angle) = r;

/***************************/

module tick(angle,offset){
    rotate([0,0,angle])
        translate([0,radius(ring_radius,angle),0]){
            hull(){
                cube(slot_width);
                translate([0,ring_thickness-slot_width,0])
                    cube(slot_width);
            }
        }
    hull(){
        rotate([0,0,angle])
            translate([0,radius(ring_radius,angle)
                    +ring_thickness*offset
                    -slot_width*offset,0]){
                cube(slot_width);
                
            }
        rotate([0,0,angle+step_angle/2])
            translate([0,radius(ring_radius,angle+step_angle/2)
                    +ring_thickness*offset
                    -slot_width*offset,0]){
                cube(slot_width);
                
            }
    }
}

module ring_base(){
    for (angle=[0:0.5:360])
        rotate([0,0,angle])
            translate([0,radius(ring_radius,angle),0])
                cube([slot_width,ring_thickness,slot_height]);
        

}

module ring(){
    ring_base();
    translate([0,0,ring_depth])
        for (angle=[0:step_angle:360]){
            tick(angle,0);
            tick(angle+step_angle/2,1);
        }
}

module handle_adapter(){
    x = 10;
    z = 2;
    translate([ring_radius+ring_thickness/2,0,ring_depth+slot_height-0.2])
    translate([0,0,z/4])
        difference(){
            hull(){
                cube([x,x,z/2],center=true);
                translate([5,0,x/2])
                    rotate([0,60,0])
                        cube([x,x,z*3],center=true);
            }
            translate([5,0,x/2])
                rotate([0,-30,0])
                    handle(x=8.4);
        }
}

module handle(r = 1,x=8){
    length = 180;
    translate([length/2-r*2,0,0])
    minkowski(){
        sphere(r);
        cube([length,x-r*2,x-r*2],center=true);
    }
}


// Uncomment 
ring();
handle_adapter();


//handle(x=8);
