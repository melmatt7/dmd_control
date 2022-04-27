

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
    else if (s1 == "Float") {
        short result = myPowerDownPrep(devNum);
        return 0;
    } 
    else if (s1 == "FullLoad" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;
        std::cout << argv[2] << std::endl;
        binFile = argv[2];
    }
    else if (s1 == "MultiLoad" && argc > 2 )  {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;

        std::vector<std::string> patFiles;
        std::istringstream ss(argv[2]);
        std::string token;

        while (std::getline(ss, token, ',')) {
            patFiles.push_back(token);
            std::cout << token << std::endl;
        }

        const int imageByteSize = 1024 * 768 / 8;

        std::cout << "num_patterns " << (unsigned short)(patFiles.size()) << std::endl;

        myLoadPatterns(patFiles, imageByteSize, devNum, dmdType, (unsigned short)(patFiles.size()));

        return 0;

    }    
    else {
        std::cout << "Command line arguments are absent or not meaningful" << std::endl;
    }

    return 0;
}


