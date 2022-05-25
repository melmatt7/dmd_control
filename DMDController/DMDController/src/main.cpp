

# include "MyHeaders.h"
#include <vector>
#include <string>
#include <sstream>
#include <iostream>

// # include other stuff if needed

int main(int argc, char** argv) {

    std::cout << argc << std::endl;
    std::cout << "This is the DMD control code!" << std::endl;

    std::cout << "Arguments:" << std::endl;
    for (int jj = 0; jj < argc; jj++)
        std::cout << argv[jj] << std::endl;


    short x = USB::GetNumDev();
    std::cout << "Number of devices: " << x << std::endl;

    short devNum = x - 1;
    short dmdType = USB::GetDMDTYPE(devNum);

    std::string binFile;
    std::string patFileDir = "DMDController/";
    std::string s1("Default");

    if (argc > 1)
        s1 = argv[1];
        
    std::cout << "Call mode:  " << s1 << std::endl;
    
    if (s1 == "Init") {
        int myFlag = myInitializeDMD(devNum);
            
        std::cout << "Initialization result: " << myFlag << std::endl;
        return 0;
    }
    else if (s1 == "Global" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;

        struct Global global;
        std::vector<std::string> patFiles = stringList(argv[2]);

        const int imageByteSize = COLS * global.rows / 8;
        int numPatterns = (unsigned short)(patFiles.size());

        USB::RegisterWrite(MODE, global.mode, devNum);
        USB::RegisterWrite(PATTERN_NUM, (numPatterns - 1), devNum);

        for (int i = 0; i < (int)numPatterns; i++) {
            myLoadPattern(patFiles[i], imageByteSize, global.blocks, devNum, dmdType);
        }

        return 0;

    }
    else if (s1 == "Float") {
        struct Float floatdmd;
        USB::RegisterWrite(MODE, floatdmd.mode, devNum);
        return 0;
    } 
    else if (s1 == "Single" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;
        
        struct Single single;
        std::vector<std::string> patFiles = stringList(argv[2]);

        const int imageByteSize = COLS * single.rows / 8;
        int numPatterns = (unsigned short)(patFiles.size());

        USB::RegisterWrite(MODE, single.mode, devNum);
        USB::RegisterWrite(PATTERN_NUM, (numPatterns - 1), devNum);

        for (int i = 0; i < (int)numPatterns; i++) {
            myLoadPattern(patFiles[i], imageByteSize, single.blocks, devNum, dmdType);
        }

        return 0;

    }
    else if (s1 == "Dual" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;

        struct Dual dual;
        std::vector<std::string> patFiles = stringList(argv[2]);

        const int imageByteSize = 1024 * dual.rows / 8;
        int numPatterns = (unsigned short)(patFiles.size());

        USB::RegisterWrite(MODE, dual.mode, devNum);
        USB::RegisterWrite(PATTERN_NUM, (numPatterns - 1), devNum);

        for (int i = 0; i < (int)numPatterns; i++) {
            myLoadPattern(patFiles[i], imageByteSize, dual.blocks, devNum, dmdType);
        }

        return 0;

    }
    else if (s1 == "Quad" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;

        struct Quad quad;
        std::vector<std::string> patFiles = stringList(argv[2]);

        const int imageByteSize = 1024 * quad.rows / 8;
        int numPatterns = (unsigned short)(patFiles.size());

        USB::RegisterWrite(MODE, quad.mode, devNum);
        USB::RegisterWrite(PATTERN_NUM, (numPatterns - 1), devNum);

        for (int i = 0; i < (int)numPatterns; i++) {
            myLoadPattern(patFiles[i], imageByteSize, quad.blocks, devNum, dmdType);
        }
        return 0;

    }
    else if (s1 == "Phased" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;

        struct Phased phased;
        std::vector<std::string> patFiles = stringList(argv[2]);

        const int imageByteSize = 1024 * phased.rows / 8;
        int numPatterns = (unsigned short)(patFiles.size());

        USB::RegisterWrite(MODE, phased.mode, devNum);
        USB::RegisterWrite(PATTERN_NUM, (numPatterns - 1), devNum);

        for (int i = 0; i < (int)numPatterns; i++) {
            myLoadPattern(patFiles[i], imageByteSize, phased.blocks, devNum, dmdType);
        }
        return 0;

    }
    else {
        std::cout << "Command line arguments are absent or not meaningful" << std::endl;
    }

    return 0;
}