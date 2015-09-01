$fn=100;

module nema17(
nema_height=39.1,
nema_width=42.1,
nema_shaft=5,
){
  union(){
    // base
    color("Silver") minkowski(){
      cube([nema_width-10,nema_width-10,(nema_height-1)],center=true);
      cylinder(r=5,h=1,center=true);
    }
    // threaded hole
    translate([15.5,15.5,15]) cylinder(d=4,h=12);
    translate([-15.5,15.5,15]) cylinder(d=4,h=12);
    translate([15.5,-15.5,15]) cylinder(d=4,h=12);
    translate([-15.5,-15.5,15]) cylinder(d=4,h=12);
    // shaft
    color("Gray") cylinder(r=nema_shaft/2,h=nema_height);
    // ring
    color("Silver") translate([0,0,nema_height/2+1]) 
      cylinder(r=11.5,h=20,center=true);
  }
}

module lm_hole(){
  //lm8uu hole
  translate([42,50,0]) cube([24,10,10],center=true);
  //zip tie holes
  translate([50,40,0]) cube([4,3,11],center=true);
  translate([34,40,0]) cube([4,3,11],center=true);
  translate([50,60,0]) cube([4,3,11],center=true);
  translate([34,60,0]) cube([4,3,11],center=true);
}


module rod_support(){
  //rod supports
  translate([40,-36,0]) rotate([0,90,0]) linear_extrude(height=3,center=true) polygon(points=[[0,0],[39.1,0],[39.1,10],[0,10]], paths=[[0,1,2,3]]);
  translate([44,-40,0]) rotate([90,90,0]) linear_extrude(height=3,center=true) polygon(points=[[0,0],[39.1,0],[39.1,10],[0,10]], paths=[[0,1,2,3]]);
  translate([36,-40,0]) rotate([-90,90,0]) linear_extrude(height=3,center=true) polygon(points=[[0,0],[39.1,0],[39.1,10],[0,10]], paths=[[0,1,2,3]]);
  translate([40,-44,0]) rotate([180,90,0]) linear_extrude(height=3,center=true) polygon(points=[[0,0],[39.1,0],[39.1,10],[0,5]], paths=[[0,1,2,3]]);
  translate([40,-40,-6]) cylinder(h=10,r1=8,r2=16);
  translate([40,-40,-39.1]) cylinder(h=10,r1=12,r2=6);
}



module holder(){
  difference(){
    cylinder(d=16,h=39.2);
    translate([0,0,16]) cylinder(d=8,h=39.3);
    translate([0,0,-10]) cylinder(d=4,h=60);
    translate([0,0,5]) cylinder(d1=4,d2=10.1,h=12);
  }
}


module base() color("Olive") {
  difference(){
    //base
    cube([120,120,5],center=true);
    //lm8uu holes
    lm_hole();
    translate([-84,0,0]) lm_hole();
    translate([-84,-60,0]) lm_hole();
    translate([0,-60,0]) lm_hole();
    //holder hole
    translate([0,-50,0]) cylinder(d=8,h=10,center=true);
    translate([0,50,0]) cylinder(d=8,h=10,center=true);
    translate([-50,20,0]) cylinder(d=8,h=10,center=true);
    translate([50,20,0]) cylinder(d=8,h=10,center=true);
  }
  //rods' supports
  translate([0,0,-2.5])  rod_support();
  translate([-80,0,-2.5]) rod_support();
  //round holders
  translate([0,-50,-41.5]) holder();
  translate([0,50,-41.5]) holder();
  translate([-50,20,-41.5]) holder();
  translate([50,20,-41.5]) holder();
}


difference(){
//base plate
base();
//steppers
translate([38,-71,-22.06]) rotate([0,0,7]) nema17();
translate([-38,-71,-22.06]) nema17();
translate([0,20,-22.06]) nema17();
//rods
translate([40,-40,0]) cylinder(d=8,h=100,center=true);
translate([-40,-40,0]) cylinder(d=8,h=100,center=true);
}
