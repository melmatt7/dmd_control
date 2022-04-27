

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

    // char* inputState = argv[1];

    short x = USB::GetNumDev();
    std::cout << "Number of devices: " << x << std::endl;

    short devNum = x - 1;
    short dmdType = USB::GetDMDTYPE(devNum);

 

    std::string binFile;
    std::string patFileDir = "DMDController/";
    // TODO argv[1] non-existent case

    std::string s1("Default");
    //std::string s1(argv[1]);
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
    else if (s1 == "Pos" && argc == 6) {
        int bh = std::atoi(argv[2]);
        int bw = std::atoi(argv[3]);
        int topBuffer = std::atoi(argv[4]);
        int leftBuffer = std::atoi(argv[5]);
        myActiveBoxPositioning(bh, bw, topBuffer, leftBuffer, devNum);
        return 0;
    }
    else if (s1 == "EmbedLoad" && argc == 7) {
        int bh = std::atoi(argv[2]);
        int bw = std::atoi(argv[3]);
        int topBuffer = std::atoi(argv[4]);
        int leftBuffer = std::atoi(argv[5]);
        binFile = argv[6];
        std::string patFilename = patFileDir + binFile;
        myActiveBoxEmbedPattern(patFilename, bh, bw,
            topBuffer, leftBuffer, devNum);
        return 0;
    }
    else if ((s1 == "EmbedPointScan") && (argc == 9) ) {
        int bh = std::atoi(argv[2]);
        int bw = std::atoi(argv[3]);
        int topBuffer = std::atoi(argv[4]);
        int leftBuffer = std::atoi(argv[5]);
        int loch = std::atoi(argv[6]);
        int locw = std::atoi(argv[7]);
        int binSize = std::atoi(argv[8]);
        
        myActiveBoxEmbedPointScan(bh, bw, topBuffer, leftBuffer, loch, locw, binSize, devNum);
        
        return 0;
    }
    else if (s1 == "FullLoad" && argc > 2) {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;
        std::cout << argv[2] << std::endl;
        binFile = argv[2];
    }
    else if (s1 == "mult" && argc > 2 )  {
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;

        std::vector<std::string> patFiles;
        //std::string arg = "data/left.bmp,data/right.bmp";
        std::istringstream ss(argv[2]);
        std::string token;

        while (std::getline(ss, token, ',')) {
            patFiles.push_back(token);
            std::cout << token << std::endl;
        }

        //const int imageByteSize = 1920 * 1080 / 8;
        const int imageByteSize = 1024 * 768 / 8;

        std::cout << "num_patterns " << (unsigned short)(patFiles.size()) << std::endl;

        myLoadPatterns(patFiles, imageByteSize, devNum, dmdType, (unsigned short)(patFiles.size()));

        return 0;

        /*
        const int numPatterns = std::atoi(argv[5]);
        std::string patFileName[] = std::atoi(argv[2]);
        int imageByteSize[] = std::atoi(argv[3]);
        int topBuffer = std::atoi(argv[4]);
        int leftBuffer = std::atoi(argv[5]);
        */
    }    
    else {
        std::cout << "Command line arguments are absent or not meaningful" << std::endl;
        std::cout << "Loading default pattern into DMD ..." << std::endl;
        std::cout << "Patterns are currently accessed from "
            << patFileDir << std::endl;
        binFile = "data/zebra1.bin";
        //binFile = "data/AcBoxTest.bin";
    }
            
        
    //std::string patFilename = "DMDController/data/zebra1.bin";
    
    std::string patFilename = patFileDir + binFile;
    //const int imageByteSize = 1920 * 1080 / 8;
    const int imageByteSize = 1024 * 768 / 8;

    myLoadPattern(patFilename, imageByteSize, devNum, dmdType);

    //myLoadZebra(true);

    // myTemp::SaveZebra(true);

    // myLoadZebra(false);

    //for (int j = 0; j < 30; j++) {
    //    myLoadZebra(j % 2); // TODO: UNCOMMENT  
    //    
    //}


    return 0;
}


