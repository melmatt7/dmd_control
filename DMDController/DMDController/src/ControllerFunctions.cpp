
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
    FPGAFile.open("DMDController/vendor/D4100_GUI_FPGA.bin", std::ios::in|std::ios::binary);
    long writeSize = 1569584;

    unsigned char* writeBuffer = new unsigned char[writeSize];

    if (FPGAFile) {
        FPGAFile.read(reinterpret_cast<char*>(writeBuffer), writeSize);
        FPGAFile.close();
    }
    else {
        std::cout << "Error opening D4100_GUI_FPGA.bin !" << std::endl;
        exit(1);
    }
    
    int result = USB::program_FPGA(writeBuffer, writeSize, devNum);

    delete[] writeBuffer;
    return result;
}               
                                                
int myLoadLive(unsigned char* myFullPattern, const int DMDByteSize, short devNum) {
    
    const int DMDBytesPerRow = 128;
    const int DMDRowsPerBlock = 48;

    short dmd_type;
    dmd_type = USB::GetDMDTYPE(devNum);
    std::cout << "dmd type " << dmd_type << std::endl;
    
    USB::SetBlkMd(0, 0);         //Set BlkMode to No Op
    USB::SetRowMd(3, 0);       //Set Row Mode to Set Address mode
    USB::SetRowAddr(0, 0);                      //Set the Row address to the top of the DMD

    USB::LoadData(&myFullPattern[0], DMDBytesPerRow, dmd_type, devNum);  //Load the first row of data  (e2e)
    Sleep(1);
    USB::SetRowMd(1, 0);              //Set the DMD pointer to Increment mode  (e2e)
    USB::LoadData(&myFullPattern[DMDBytesPerRow], DMDBytesPerRow * (DMDRowsPerBlock - 1), dmd_type, devNum);  //Load the rest of Block 1
    Sleep(1);
    for (int i = 1; i < 16; i++) {
        USB::LoadData(&myFullPattern[DMDBytesPerRow * DMDRowsPerBlock * i], DMDBytesPerRow * DMDRowsPerBlock, dmd_type, devNum);  //Load the other 14 blocks
    }
    
    
    int status = 0;

    status += USB::SetRowMd(0, devNum);
    status += USB::SetBlkMd(3, devNum);
    status += USB::SetBlkAd(8, devNum);
    status += USB::LoadControl(devNum);
    Sleep(1);
    status += USB::SetBlkMd(0, devNum);
    status += USB::LoadControl(devNum);
    status += USB::LoadControl(devNum);

    return status;
}

void myLoadZebra(bool zebraState) {

    using namespace USB;

    SetBlkMd(0, 0);         //Set BlkMode to No Op
    SetRowMd(3, 0);       //Set Row Mode to Set Address mode
    SetRowAddr(0, 0);                      //Set the Row address to the top of the DMD

    const int DMDBytesPerRow = 128;
    const int DMDRowsPerBlock = 48;
    const int BlocksPerLoad = 2;

    short dmd_type;
    dmd_type = USB::GetDMDTYPE(0);
    std::cout << "dmd type " << dmd_type << std::endl;

    unsigned char* zebra = new unsigned char[1024 * 768 / 8];

    if (zebraState) {

        for (int i = 0; i < 1024 * 768 / 8; i++)
        {
            if (i % (128) < 64)
                zebra[i] = 0x00;
            else
                zebra[i] = 0xff;
        }
    }
    else {
        for (int i = 0; i < 1024 * 768 / 8; i++)
        {
            if (i % (128) < 64)
                zebra[i] = 0xff;
            else
                zebra[i] = 0x00;
        }
    }

    int status = myLoadLive(zebra, 0, 0);

    delete[] zebra;
}

short myPowerDownPrep(short devNum) {
    USB::SetRowMd(0, 0);
    USB::SetBlkMd(3, 0);
    USB::SetBlkAd(12, 0);
    USB::LoadControl(0);
    
    Sleep(1);
    USB::SetBlkMd(0, 0);
    
    USB::LoadControl(0);
    USB::LoadControl(0);
    return 0;
}

void myLoadPattern(std::string patFilename, const int imageByteSize, short devNum, short dmdType) {
    const int DMDBytesPerRow = 128;
    const int DMDRowsPerBlock = 48;

    std::cout << "dmd type " << dmdType << std::endl;



    std::fstream datFile;


    datFile.open(patFilename, std::ios::in | std::ios::binary);
    unsigned char* myPattern = new unsigned char[1024 * 768 / 8];

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

    int status = myLoadLive(myPattern, imageByteSize, devNum);    

    delete[] myPattern;

}

void myLoadPatterns(std::vector<std::string> patFilename, const int imageByteSize, short devNum, short dmdType, unsigned short numPatterns) {
    
    int writeval;
    writeval = USB::RegisterWrite(PATTERN_NUM, (numPatterns-1), devNum);

    for (int i = 0; i < (int)numPatterns; i++) {
        myLoadPattern(patFilename[i], imageByteSize, devNum, dmdType);
    }

    std::cout << "writen both" << '\n';

}
    
