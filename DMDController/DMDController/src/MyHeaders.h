#pragma once
# include <iostream>
# include <fstream>
# include <string>
# include <algorithm>
# include <Windows.h>
# include <stdlib.h>
#include <vector>
# include "8055.D4100_usb.h"
# include "CyAPI.h"
# include "RegisterDefines.h"
// defined in testFunctions.cpp :
void myCheckRowModes();

// defined in ControllerFunctions.cpp :
int myInitializeDMD(short devNum);
int myReprogramFPGA(short int devNum);

int myLoadLive(unsigned char* myPattern, const int DMDByteSize, short devNum);

void myLoadZebra(bool zebraState);
short myPowerDownPrep(short devNum);
void myLoadPattern(std::string patFilename, const int imageByteSize, short devNum, short dmdType);
void myLoadPatterns(std::vector<std::string> patFilename, const int imageByteSize, short devNum, short dmdType, unsigned short numPatterns);
