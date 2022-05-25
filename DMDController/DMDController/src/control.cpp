
# include "MyHeaders.h"


int myInitializeDMD(short devNum) {
    
    using namespace USB;

    short w;
    long y;
    short int z;
    y = GetDLLRev();
    z = GetUsbSpeed(devNum);
    w = GetDMDTYPE(devNum);

    
    std::cout << "DLL version info: " << y << std::endl;
    std::cout << "USB speed: " << z << std::endl;
    std::cout << "DMD type: " << w << std::endl;


    int fl0 = myReprogramFPGA(devNum);
    std::cout << "repro flag: " << fl0 << std::endl;
    short fl1 = SetWDT(1, devNum); // Enable WDT
    short fl2 = (0, devNum); // Disable TestPatternGenerator
    short fl3 = ClearFifos(devNum); // Initialize the DMD fifo.

    int myOutput = fl0 && fl1 && fl2 && fl3;
    return myOutput;
}

int myReprogramFPGA(short int devNum) {

    std::fstream FPGAFile;
    //FPGAFile.open("DMDController/vendor/D4100_GUI_FPGA.bin", std::ios::in | std::ios::binary);
    FPGAFile.open("../APPSFPGA_MEM/appsfpga.bin", std::ios::in|std::ios::binary);
    long writeSize = 1569584;

    unsigned char* writeBuffer = new unsigned char[writeSize];

    if (FPGAFile) {
        FPGAFile.read(reinterpret_cast<char*>(writeBuffer), writeSize);
        FPGAFile.close();
    }
    else {
        std::cout << "Error opening appsfpga.bin !" << std::endl;
        exit(1);
    }
    
    int result = USB::program_FPGA(writeBuffer, writeSize, devNum);

    delete[] writeBuffer;
    return result;
}                                                        

void myLoadPattern(std::string patFilename, const int imageByteSize, const int blocks, short devNum, short dmdType) {
    std::cout << "dmd type " << dmdType << std::endl;

    std::fstream datFile;

    datFile.open(patFilename, std::ios::in | std::ios::binary);
    unsigned char* myPattern = new unsigned char[imageByteSize];

    if (datFile) {
        datFile.read(reinterpret_cast<char*>(myPattern), imageByteSize);
        datFile.close();
    }
    else {
        std::string errMsg = std::string("Error opening pattern file: ") + patFilename;
        std::cout << errMsg << std::endl;
        exit(1);
    }

    Sleep(10);

    USB::LoadData(&myPattern[0], BYTESPERROW, dmdType, devNum);  //Load the first row of data  (e2e)
    Sleep(1);
    USB::LoadData(&myPattern[BYTESPERROW], BYTESPERROW * (ROWSPERBLOCK - 1), dmdType, devNum);  //Load the rest of Block 1
    Sleep(1);
    for (int i = 1; i < blocks; i++) {
        USB::LoadData(&myPattern[BYTESPERROW * ROWSPERBLOCK * i], BYTESPERROW * ROWSPERBLOCK, dmdType, devNum);  //Load the other 15 blocks
    }

    delete[] myPattern;
}

std::vector<std::string> stringList(char* stream) {
    std::vector<std::string> patFiles;
    std::istringstream ss(stream);
    std::string token;

    while (std::getline(ss, token, ',')) {
        patFiles.push_back(token);
        std::cout << token << std::endl;
    }

    return patFiles;
}