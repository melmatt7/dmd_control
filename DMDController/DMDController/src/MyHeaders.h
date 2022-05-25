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
#include <sstream>

const int COLS = 1024;
const int BYTESPERROW = 128;
const int ROWSPERBLOCK = 48;

struct Global {
    int mode = 0;
    int blocks = 16;
    int rows = 768;
};

struct Float {
    int mode = 1;
    int blocks = 16;
    int rows = 768;
};

struct Single {
    int mode = 2;
    int blocks = 1;
    int rows = 48;
};

struct Dual {
    int mode = 3;
    int blocks = 2;
    int rows = 96;
};

struct Quad {
    int mode = 4;
    int blocks = 4;
    int rows = 192;
};

struct Phased {
    int mode = 5;
    int blocks = 1;
    int rows = 48;
};

int myInitializeDMD(short devNum);
int myReprogramFPGA(short int devNum);
void myLoadPattern(std::string patFilename, const int imageByteSize, const int blocks, short devNum, short dmdType);
std::vector<std::string> stringList(char* stream);
