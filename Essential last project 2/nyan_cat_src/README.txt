AUTHORS
	Taylor Cowley
	Ken Saywer
COURSE
	EcEN 320 Winter 2016
	Dr Mike Wirthlin
	Brigham Young University
SUMMARY
	This project will output an animation of Nyan cat on the VGA display,
	and will, with a proper virtual ground (and optional low-pass filter)
	also output the music to nyan cat. The background of the animation
	changes colors depending on the switches.
INSTRUCTIONS
	nyan_cat.txt needs to be written to the SRAM. This contains the animation and sound data.
	nyan_cat.bit is to be written and run on the FPGA.
	
	For the sound output to work, a virtual ground needs to be made.
	This is easily done on an optional attached breadboard.
	
	Two 10 microfarad capacitors are connected in series, with two 4.7kOhm resistors in parallel with each capacitor
	The two sides of the setup need to be connected to the FPGA's ground and VCC.
	In the middle is the virtual ground.
	
	The signal can be connected to a common sound input cord by connecting the virtual ground
	to the top of the cable's plug, and IO1 from the FPGA to either the tip or the middle of the plug (or both)
	
	Change the switches to change the background color!
FUTURE WORK
	It would be cool to be able to do different sounds or different pictures, but everything is hard-coded at this point
	
	For more analog work, the sound sounds a lot better when hooked up to a hefty low-pass filter.
	If we had more time, we'd like to create a low-pass filter and amplifier to connect up an on-board
	speaker/buzzer to produce louder music.	
	
PROJECT BUILD OPTIONS
	Be sure to initialize the memory with nyan_cat.txt.

PROJECT SIZE
	Design Summary
	--------------
	Logic Utilization:
	Number of Slice Flip Flops:           513 out of   9,312    5%
	Number of 4 input LUTs:               744 out of   9,312    7%
	Logic Distribution:
	Number of occupied Slices:            472 out of   4,656   10%
	Number of Slices containing only related logic:     472 out of     472 100%
    Number of Slices containing unrelated logic:          0 out of     472   0%
      *See NOTES below for an explanation of the effects of unrelated logic.
	Total Number of 4 input LUTs:         850 out of   9,312    9%
    Number used as logic:               743
    Number used as a route-thru:        106
    Number used as Shift registers:       1

	The Slice Logic Distribution report is not meaningful if the design is
	over-mapped for a non-slice resource or if Placement fails.

	Number of bonded IOBs:                 80 out of     232   34%
	Number of BUFGMUXs:                     1 out of      24    4%

	
	
	Design Summary Report:

	Number of External IOBs                          80 out of 232    34%

	Number of External Input IOBs                 26

    Number of External Input IBUFs             26
    Number of LOCed External Input IBUFs     26 out of 26    100%


	Number of External Output IOBs                54

    Number of External Output IOBs             54
    Number of LOCed External Output IOBs     54 out of 54    100%


	Number of External Bidir IOBs                  0


	Number of BUFGMUXs                        1 out of 24      4%
	Number of Slices                        472 out of 4656   10%
    Number of SLICEMs                     37 out of 2328    1%
	
	
	
	
	