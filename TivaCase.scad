// OpenSCAD 2019.05
// Tiva Case - enclosure, REV-001
// Joe Haas, KE0FF, 12/16/2021
// This is an enclosure for an EK-TM4C123GXL LaunchPad board and a custom LaunchPad
//	carrier board.
//
// Rev-001, 12/16/2021
//	initial code -- copied from uxcover

//use <char.scad>

//----------------------------------------------------------------------------------------------------------------------
// User defined parameters.  Modify these to suit a particular application
// NOTE: All data in this file is in mm

//----------------------------------------------------------------------------------------------------------------------
// parametric variables:

width = 67.5;
wcut = 10;
length = 87.2;
lcut = 10;
height = 20.8; //28.2;
heightl = 3;
wthick = 3.5;
wthickt = 1.5;
crad = 5;
crad2 = crad/2;

// X-rulers
//#translate([-.69,0,0]) cube([0.01,30,50]);	// ruler
//#translate([175.41,0,0]) cube([0.01,30,50]);	// inside main void ruler 1
//#translate([1.67,0,0]) cube([0.01,30,50]);	// inside main void ruler 2
//#translate([175.34,0,0]) cube([0.01,30,50]);	// outside shroud ruler 2
// Y-rulers
//#translate([0,23.81,0]) cube([180,0.01,50]);	// ruler
//#translate([0,22.36 ,0]) cube([180,0.01,50]);	// ruler
// Z-rulers
//#translate([0,0,0]) cube([10,40,.01]);	// ruler
//#translate([0,0,2.04]) cube([9,40,.01]);	// ruler

// Set each variable to "1" to render that part (only one part at a time).  Set all = "0" to enable composite
//	rendering (below).

plotlid = 0;
plotcase = 0;
plotlp = 0;

/////////////////////////////////////

if(plotlid) lid(1);
if(plotlp) lid_lpipe();
if(plotcase) case();

// Composite plot.  Places all elements in an assembly orientation

if(!plotlid && !plotlp && !plotcase){
//	translate([0,0,0]) tiva_lp();
	difference(){
		union(){
			color("darkslategray",0.98) case();
			translate([0,length,height+heightl]) rotate([180,0,0]) color("darkslategray",1.0) lid(1);
			translate([0,length,height+heightl]) rotate([180,0,0]) lid_lpipe();
		}
//		translate([-1,-1,-1]) cube([90,60,90]);
	}
}

//////////////////****************\\\\\\\\\\\\\\\\\\
				//    modules     \\
				//****************\\

///////////////
// Bottom shell

module case(){
	difference(){
		union(){
			difference(){
				union(){
					cube([width,length,height]);
				}
				cube([crad,crad,60], center=true);
				translate([width,0,0]) cube([crad,crad,60], center=true);
				translate([0,length,0]) cube([crad,crad,60], center=true);
				translate([width,length,0]) cube([crad,crad,60], center=true);
				translate([3.5,3.5,4.5]) cube([60.5,80.2,21.2]);
				translate([3.5+6.5,3.5,4.5-2.5]) cube([60.5-13,80.2,5]);
				translate([3.5,3.5+6+3,4.5-2.5]) cube([60.5,80.2-12-6,5]);
				translate([57.3,47,.5]) cube([5,11.4,4.5]);								// jtag port
				translate([width/2,length/2,11]) tiva_lp_mtg(10);
				translate([width/2,length/2,0]) tiva_lp_mtg_cs();
				translate([.08+(width/2),1.5,9]) rotate([270,0,0]) db9();
				translate([width/2,length/2,11]) sma_pilot();
				translate([width/2,length/2,11]) sma2_pilot();
				translate([width/2,length/2+21.4,11]) sma2_pilot();
				translate([8,1,15.9]) cube([width-14.5,3,2.1]);							// tiva groove
				translate([(width-15)/2,-.01,height-2.7]) cube([15,wthickt,2.8]);		// lip0
			}
			translate([crad2,crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
			translate([width-crad2,crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
			translate([crad2,length-crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
			translate([width-crad2,length-crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
		}
		translate([17.5,length-4,18]) pilot(1);											// usb pilot
		translate([25,length-4,17.3]) pilot();											// pilot
		translate([47,length-4,17.3]) pilot();											// pilot
		translate([4,20,17.3]) rotate([0,0,90]) pilot();								// pilot
		translate([4,67,17.3]) rotate([0,0,90]) pilot();								// pilot
		translate([width-4,20,17.3]) rotate([0,0,90]) pilot();							// pilot
		translate([width-4,67,17.3]) rotate([0,0,90]) pilot();							// pilot
	}
}

////////////
// Top cover

module lid(hole){
	difference(){
		union(){
			difference(){
				union(){
					cube([width,length,heightl]);
				}
				cube([crad,crad,60], center=true);
				translate([width,0,0]) cube([crad,crad,60], center=true);
				translate([0,length,0]) cube([crad,crad,60], center=true);
				translate([width,length,0]) cube([crad,crad,60], center=true);
				translate([wthick,wthick,2]) cube([60.5,80.2+wthickt,21.2]);
				translate([0,length,(height+heightl)]) rotate([180,0,0]) tiva_lp(1);
			}
			translate([wcut/2,wthick,0]) cube([width-wcut,wthick,10]);							// lip
			translate([(width-15)/2,length-(wthickt)-.001,0]) cube([15,wthickt,5.5]);			// lip0
			translate([wthick,wcut/2,0]) cube([wthick,length-wcut,10]);							// lip
			translate([width-(2*wthick),wcut/2,0]) cube([wthick,length-wcut,10]);				// lip
			translate([crad2,crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);
			translate([width-crad2,crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);
			translate([crad2,length-crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);
			translate([width-crad2,length-crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);
		}
		translate([20,4,6.5]) pilot();															// pilot
		translate([47,4,6.5]) pilot();															// pilot
		translate([4,20,6.5]) rotate([0,0,90]) pilot();											// pilot
		translate([4,67,6.5]) rotate([0,0,90]) pilot();											// pilot
		translate([width-4,20,6.5]) rotate([0,0,90]) pilot();									// pilot
		translate([width-4,67,6.5]) rotate([0,0,90]) pilot();									// pilot
	}
}

/////////////////////////////////////
// Light pipe (inserts into top cover

module lid_lpipe(hole){
	translate([0,length,(height+heightl)]) rotate([180,0,0]) tiva_lp(10);
}

////////////////////////////////////////////////////////////////////////
// LaunchPad assembly (not for 3D printing, only for assembly fit check)

module tiva_lp(hole=0){
	translate([(width/2)-30.05,(length/2)-37.7,11-6.4]) difference(){
		union(){
			if(hole == 0){
				translate([14.4,0.1,12.5]) pbsw(hole);
				translate([45.2,0.1,12.5]) pbsw(hole);
				translate([49.1,43,12.5]) pbsw(hole);
				color("green",1.0) cube([60.1,75.4,.8]);
				color("black",1.0) translate([6.4,6.6,0.01]) cube([4.9,25.7,12]);
				color("black",1.0) translate([49.5,6.6,0.01]) cube([4.9,25.7,12]);
				color("red",1.0) translate([5,-4.3,11.8]) cube([50.8,66,.8]);
				translate([13.3,0,0]) sma();
				translate([47,0,0]) sma();
				translate([5,41.2,12.5]) rotate([0,0,270]) usb();
				translate([14,61.7,12.5]) rotate([0,0,180]) usb();
				color("white",.5) translate([53.7,36.2,12.5]) cylinder(r=.5, h=20, $fn=32, center=false);
				color("white",1.0) translate([54.4,42.1,-4.5]) cube([3.3,9.2,4.5]);
			}else{
				if(hole == 10){
					difference(){
						color("white", 0.8) translate([53.7,36.2,12.4]) cylinder(r=2, h=6.8, $fn=32, center=false);
						 translate([53.7,36.2,11.4]) sphere(r=2,$fn=32);
					}
				}else{
					translate([53.7,36.2,12.4]) cylinder(r=2, h=10, $fn=32, center=false);
					translate([14.4,0.1,12.5]) pbsw(hole);
					translate([45.2,0.1,12.5]) pbsw(hole);
					translate([49.1,43,12.5]) pbsw(hole);
				}
			}
		}		
		translate([30.05,37.7,6.4]) tiva_lp_mtg();
	}
}

//////////////////////////////
// Tiva carrier mounting holes

module tiva_lp_mtg(depth=2){
	translate([-30.05,-37.7,-6.4]) union(){
		translate([3.4,3.4,0]) cylinder(r=1.6, h=depth, $fn=32, center = true);
		translate([56.5,3.4,0]) cylinder(r=1.6, h=depth, $fn=32, center = true);
		translate([3.4,71.9,0]) cylinder(r=1.6, h=depth, $fn=32, center = true);
		translate([56.5,71.9,0]) cylinder(r=1.6, h=depth, $fn=32, center = true);
	}
}

//////////////////////////////////////////
// Tiva carrier mounting hole countersinks

module tiva_lp_mtg_cs(screw=4){
	if(screw == 2){
		translate([-30.05,-37.7,.64]) union(){
			translate([3.4,3.4,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
			translate([56.5,3.4,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
			translate([3.4,71.9,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
			translate([56.5,71.9,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
		}
	}else{
		translate([-30.05,-37.7,.64]) union(){
			translate([3.4,3.4,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
			translate([56.5,3.4,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
			translate([3.4,71.9,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
			translate([56.5,71.9,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
		}
	}
}

/////////////////////////////////////
// SMA connector (fit check artifact)
module sma(){
  union(){										// "-"
	translate([-4.75,0,-4.6]) cube([9.5,6.7,7.9]);
	translate([0,0,-.75]) rotate([90,0,0]) cylinder(r=3.1, h=7.5, $fn=32);
  }
}

/////////////////////////////////////////////////////
// SMA pilot holes and clearences (part of 3D render)

module sma_pilot(){
  translate([-30.05,-37.7,-6.4]) union(){										// "-"
	translate([8.05,0,-4.1]) cube([10.5,3,7.9]);
	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);
	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
	translate([8.05+(47-13.3),0,-4.1]) cube([10.5,3,7.9]);
	translate([47,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);
	translate([47,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
  }
}

/////////////////////////////////////////////////
// Side-mount SMA pilot holes (part of 3D render)

module sma2_pilot(){
  translate([-32,-21+38.2,-6.4]) rotate([0,0,270]) union(){										// "-"
	translate([8.05,0,-4.1]) cube([10.5,3,7.9]);
	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);
//	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
  }
}

/////////////////////////
// scant opening for PBSW

module pbsw(hole=0){
  union(){										// "-"
	if(hole == 0){
		color("darkslategray",1.0) translate([-3.05,-3.05,0]) cube([6.1,6.1,3.4]);
		color("black",1.0) translate([0,0,0]) cylinder(r=1.7, h=5, $fn=32, center=false);
		color("white",.5) translate([0,0,0]) cylinder(r=.5, h=20, $fn=32, center=false);
	}else{
		translate([0,0,-.1]) cylinder(r=3.5/2, h=10, $fn=32, center=false);
	}
  }
}

/////////////////////////////
// USB connectors (fit check)

module usb(){
  union(){										// "-"
	color("silver",1.0) translate([-3.75,-1.1,0]) cube([7.5,5.8,2.5]);
  }
}

/////////////////////
// generic pilot hole

module pilot(diameter=2){
  union(){										// "-"
	rotate([90,0,0]) cylinder(d=diameter, h=10, $fn=32, center=true);
  }
}

/////////////////////////
// DB9 cutout (3D render)

module db9(){
	translate([0,0,2.05]) union(){
		translate([0,0,0]) cube([18.44,10.06,15], center=true);								// DB9 cutout
		translate([0,0,3.0]) cube([32,14,10.1], center=true);								// DB9 CM
		translate([(101.60-76.20)/2,0,0]) cylinder(r=1.6, h=20, $fn=16, center=true);		// db9 holes,	#1
		translate([-(101.60-76.20)/2,0,0]) cylinder(r=1.6, h=20, $fn=16, center=true);		//				#2
	}
}

// EOF
