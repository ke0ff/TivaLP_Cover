// OpenSCAD 2019.05
// Tiva Case - enclosure, REV-001
// Joe Haas, KE0FF, 12/16/2021
// This is an enclosure for an EK-TM4C123GXL LaunchPad board and a custom LaunchPad
//	carrier board.
//
// Rev-003 (lid), 12/23/2021
//	(lid) added lip0 clips to remove interference
//
// Rev-002, 12/21/2021
//	incorporated fixes from first print run
//	increased lid thickness to provide more room for LP board
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
heightl = 8;
lheight = 15;
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

plotlid = 1;
plotcase = 0;
plotlp = 0;

/////////////////////////////////////

if(plotlid) lid(1);
if(plotlp) lid_lpipe();
if(plotcase) case();

// Composite plot.  Places all elements in an assembly orientation

if(!plotlid && !plotlp && !plotcase){
//	translate([0,0,0]) tiva_assy();
	difference(){
		union(){
			color("darkslategray",0.98) case();
//			translate([0,length,height+heightl]) rotate([180,0,0]) color("darkslategray",1.0) lid(1);
			translate([0,length,height+heightl+5]) rotate([180,0,0]) color("blue",1.0) lid(1);
			translate([0,length,height+heightl]) rotate([180,0,0]) lid_lpipe();
		}
//		translate([-1,-45,20.5]) cube([90,60,90]);		// cut-away viewing
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
//					translate([19.1,88,0]) cube([2,2,23.6]); // test-ruler
				}
				translate([19.1,76,15.4]) cube([10.5,16,8.1]); 							// USB shroud
				cube([crad,crad,60], center=true);										// corner notch
				translate([width,0,0]) cube([crad,crad,60], center=true);				// corner notch
				translate([0,length,0]) cube([crad,crad,60], center=true);				// corner notch
				translate([width,length,0]) cube([crad,crad,60], center=true);			// corner notch
				translate([3.5,3.5,4.5]) cube([60.5,80.2,21.2]);						// main hog-out
				translate([3.5+6.5,3.5,4.5-2.5]) cube([60.5-13,80.2,5]);				// "Y" under PCB hog-out
				translate([3.5,3.5+6+3,4.5-2.5]) cube([60.5,80.2-12-6,5]);				// "X" under PCB hog-out
				translate([57.3,47,.5]) cube([5,11.4,4.5]);								// jtag port
				translate([width/2,length/2,11]) tiva_lp_mtg(10);						// pcb mtg holes
				translate([width/2,length/2,0]) tiva_lp_mtg_cs();						// pcb mtg hole counter-sinks
				translate([.08+(width/2),1.5,9]) rotate([270,0,0]) db9();				// DB9 cutout
				translate([width/2,length/2,11]) sma_pilot();							// sma pilots (RF3 & RF4)
				translate([width/2,length/2,11]) sma2_pilot();							// sma pilots, RF2
				translate([width/2,length/2+21.4,11]) sma2_pilot();						// sma pilots, RF1
				translate([6.5,1.5,15.9]) cube([width-12.5,4,5]);						// tiva groove
//				translate([(width-15)/2,-.01,height-2.7]) rotate ([-20,0,0]) cube([15,wthickt+4,2.8]);		// lip0
//				translate([(width-15)/2,-.01,height-2.7]) rotate ([0,0,-10]) polygon([0,0],[);		// lip0
//				translate([width/2,9.99,25.6]) rotate([90,0,0]) rotate([0,0,45]) cylinder(h=10,r1=(21.2/2)+1.76,r2=21.2/2,$fn=4);
//				translate([(width-15)/2,-.01,height-2.7]) cube([15,wthickt+4,2.8]);		// lip0
			}
			translate([crad2,crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);		// corner radius (x4)
			translate([width-crad2,crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
			translate([crad2,length-crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
			translate([width-crad2,length-crad2,0]) cylinder(r=crad/2, h=height, $fn=32, center=false);
		}
//		translate([17.5,length-4,18]) pilot(1);											// usb pilot
		translate([15,length-4,17.3]) pilot();											// pilot
		translate([47,length-4,17.3]) pilot();											// pilot
		translate([4,20,17.3]) rotate([0,0,90]) pilot();								// pilot
		translate([4,67,17.3]) rotate([0,0,90]) pilot();								// pilot
		translate([width-4,20,17.3]) rotate([0,0,90]) pilot();							// pilot
		translate([width-4,67,17.3]) rotate([0,0,90]) pilot();							// pilot
		translate([15,15,1.5]) linear_extrude(1) text("REV 2", size=6);					// version & PN texts
		translate([15,25,1.5]) linear_extrude(1) text("TivaLP bot", size=6);
	}
}

////////////
// Top cover

module lid(hole){
	difference(){
		union(){
			difference(){
				union(){
					cube([width,length,heightl]);													// main lid
				}
				cube([crad,crad,60], center=true);													// corner nibble
				translate([width,0,0]) cube([crad,crad,60], center=true);							// corner nibble
				translate([0,length,0]) cube([crad,crad,60], center=true);							// corner nibble
				translate([width,length,0]) cube([crad,crad,60], center=true);						// corner nibble
				translate([wthick,wthick,2]) cube([60.5,80.2+wthickt,21.2]);						// main hog-out
				translate([0,length,(height)]) rotate([180,0,0]) tiva_assy(1);		// "1" param burns button/LP holes
			}
			translate([wcut/2,wthick,0]) cube([width-wcut,wthick,lheight]);							// lip
//			translate([(width-15)/2,length-(wthickt)-.001,5]) cube([15,wthickt,5.5]);				// lip0
			translate([wcut/2,length-(wthick/2)-(wthickt)-.001,1]) cube([width-wcut,wthick/2,8]);	// lip0
			translate([wcut/2,length-(wthick/2)-(wthickt)-2,1]) cube([2,2.1,8]);					// lip0 tie-in
			translate([width-(wthick*2),length-(wthick/2)-(wthickt)-2,1]) cube([2,2.1,8]);			// lip0 tie-in
			translate([wthick,wcut/2,0]) cube([wthick,length-wcut,lheight]);						// lip
			translate([width-(2*wthick),wcut/2,0]) cube([wthick,length-wcut,lheight]);				// lip
			translate([crad2,crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);			// corner
			translate([width-crad2,crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);	// corner
			translate([crad2,length-crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);	// corner
			translate([width-crad2,length-crad2,0]) cylinder(r=crad/2, h=heightl, $fn=32, center=false);	// corner
		}
		translate([19.1,-1,lheight-1.7-8]) cube([10.5,16,8.1]);											// USB housing
		translate([15,4,lheight-3.5]) pilot();														// pilot
		translate([47,4,lheight-3.5]) pilot();														// pilot
		translate([4,20,lheight-3.5]) rotate([0,0,90]) pilot();										// pilot
		translate([4,67,lheight-3.5]) rotate([0,0,90]) pilot();										// pilot
		translate([width-4,20,lheight-3.5]) rotate([0,0,90]) pilot();								// pilot
		translate([width-4,67,lheight-3.5]) rotate([0,0,90]) pilot();								// pilot
		translate([2.5,82.21,8.01]) cube([5,5,3]);														// corner clearance @ lip0
		translate([60,82.21,8.01]) cube([5,5,3]);														// corner clearance @ lip0
		translate([15,10,1.5]) linear_extrude(1) text("REV 3", size=6);								// version and PN texts
		translate([15,20,1.5]) linear_extrude(1) text("TivaLP top", size=6);
	}
}

/////////////////////////////////////
// Light pipe (inserts into top cover)

module lid_lpipe(hole){
	translate([0,length,(height+heightl)]) rotate([180,0,0]) tiva_assy(10);			// "10" param creates stand-alone LP
}

////////////////////////////////////////////////////////////////////////
// LaunchPad assembly (not for 3D printing, only for assembly fit check)

module tiva_assy(hole=0){
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
						union(){
							color("white", 0.8) translate([56.6-3.5,-44+length-5.9,lheight+2.4]) cylinder(r=2, h=6.8, $fn=32, center=false);
							color("white", 0.8) translate([27.9-3.5,-28.6+length-5.9,lheight+2.4]) cylinder(r=2, h=6.8, $fn=32, center=false);
						}
						translate([56.5-3.5,43.1-5.9,lheight+1.4]) sphere(r=2,$fn=32);
						translate([27.9-3.5,-28.6+length-5.9,lheight+1.4]) sphere(r=2,$fn=32);
					}
				}else{
					translate([56.6-3.5,-44+length-5.9,12.4]) cylinder(r=2, h=10, $fn=32, center=false);
					translate([27.9-3.5,-28.6+length-5.9,12.4]) cylinder(r=2, h=10, $fn=32, center=false);
					translate([18.5-3.5,-5.9+7,12.5]) pbsw(hole);
					translate([18.5-3.5+30.4,-5.9+7,12.5]) pbsw(hole);
					translate([53.6-3.5,-37.2+length-5.9,12.5]) pbsw(hole);
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
		translate([3.4,3.4,0]) cylinder(r=1.6, h=depth, $fn=32, center = true);		// #4 holes
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
			translate([3.4,3.4,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);	// #2 countersinks
			translate([56.5,3.4,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
			translate([3.4,71.9,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
			translate([56.5,71.9,0]) cylinder(r1=4.37/2, r2=2.18/2, h=1.3, $fn=32, center = true);
		}
	}else{
		translate([-30.05,-37.7,.64]) union(){
			translate([3.4,3.4,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);	// #4 countersinks
			translate([56.5,3.4,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
			translate([3.4,71.9,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
			translate([56.5,71.9,0]) cylinder(r1=5.72/2, r2=2.84/2, h=1.7, $fn=32, center = true);
		}
	}
}

/////////////////////////////////////
// SMA connector (fit check artifact)
module sma(){
  union(){
	translate([-4.75,0,-4.6]) cube([9.5,6.7,7.9]);
	translate([0,0,-.75]) rotate([90,0,0]) cylinder(r=3.1, h=7.5, $fn=32);
  }
}

/////////////////////////////////////////////////////
// SMA pilot holes and clearences (part of 3D render)

module sma_pilot(){
	translate([-30.05,-37.7,-6.4]) union(){
		translate([7.75,0,-4.1]) cube([11.5,3,7.9]);									// panel face clearance, RF4
		translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);			// barrel pilot, RF4
//		translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
		translate([7.75+(47-13.3),0,-4.1]) cube([11.5,3,7.9]);							// panel face clearance, RF3
		translate([47,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);			// barrel pilot, RF3
//		translate([47,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
	}
}

/////////////////////////////////////////////////
// Side-mount SMA pilot holes (part of 3D render)

module sma2_pilot(){
  translate([-32,-21+38.2,-6.4]) rotate([0,0,270]) union(){
	translate([8.05,0,-4.1]) cube([10.5,3,7.9]);
	difference(){	// slope roof
		translate([8.05+5.25,width+.035,-4.1]) rotate([0,90,0]) cylinder(h=10.5, r=width+.4, $fn=256, center=true);
		translate([7.9,-2,-(width*2)-3-4.1]) cube([13,(width*2)+10,(width*2)+10]);
		translate([7.9,3,-4.1]) cube([13,(width*2)+10,(width*2)+10]);		
	}
	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=.8, h=8, $fn=32);
//	translate([13.3,.1,-.75]) rotate([90,0,0]) cylinder(r=1.5, h=2.5, $fn=32);
  }
}

/////////////////////////
// scant opening for PBSW

module pbsw(hole=0){
  union(){
	if(hole == 0){
		color("darkslategray",1.0) translate([-3.05,-3.05,0]) cube([6.1,6.1,3.4]);
		color("black",1.0) translate([0,0,0]) cylinder(r=1.7, h=5, $fn=32, center=false);
		color("white",.5) translate([0,0,0]) cylinder(r=.5, h=20, $fn=32, center=false);
	}else{
		translate([0,0,-.1]) cylinder(r=4/2, h=10, $fn=32, center=false);
	}
  }
}

/////////////////////////////
// USB connectors (fit check)

module usb(){
  union(){
	color("silver",1.0) translate([-3.75,-1.1,0]) cube([7.5,5.8,2.5]);
  }
}

/////////////////////
// generic pilot hole

module pilot(diameter=2){
  union(){
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
