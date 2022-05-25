---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
Copyright © 2018 Texas Instruments Incorporated - http://www.ti.com/        
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

Product name: Discovery 4100 Apps FPGA Pattern Generator Code
Version: 2.0
Date:  December 2018

---------------------------------------------------------------------------------------------------------------------------
DESCRIPTION
---------------------------------------------------------------------------------------------------------------------------
Discovery 4100 Apps FPGA Pattern Generator VHDL Code
	Design Guide - DLPU045

---------------------------------------------------------------------------------------------------------------------------
FEATURES 
---------------------------------------------------------------------------------------------------------------------------
V1.0 
Automatically generates patterns that display on a Discovery 4100 EVM
Allows testing via on-board switches of: 
    · Float mirrors
    · Pause / Resume pattern display (halts Apps FPGA internal counter)
    · Compliment data & N/S flip
    · Single, Dual, Quad & Global block mode mirror clocking pulses
    · Automatic row counter and Ros address mode loading
    · Enable / Disable mirror clocking pulse watchdog timer

V2.0
Added pattern generation support for the DLP650LNIR DMD.
Added GUI scripting support for the DLP650LNIR DMD.
Added support for the GUI to override the on board switches (with any supported DMD).
Added support for the GUI to select the internal pattern displayed.


---------------------------------------------------------------------------------------------------------------------------
REVISION HISTORY
---------------------------------------------------------------------------------------------------------------------------

1.0
* Initial release

2.0
* Added support for the DLP650LNIR DMD (still supporting previous DMDs)
* Merged that Pattern Generator code with the GUI downloadable FPGA version
* Removed the DDR memory controller to get the above components merged. 

---------------------------------------------------------------------------------------------------------------------------
RESTRICTIONS
---------------------------------------------------------------------------------------------------------------------------
1.0
* This version only works with GUI v1.0 and DLPC410 configured by the DLPR410.

2.0
* This version only works with GUI v2.0 and DLPC410 configured by the DLPR410A.

---------------------------------------------------------------------------------------------------------------------------
CONTACT US
---------------------------------------------------------------------------------------------------------------------------
At http://e2e.ti.com/
Post your questions in the DLP & MEMS / New DLP Applications & Technology section of the TI E2E Forum.
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
