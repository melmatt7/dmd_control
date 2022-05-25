import numpy as np
import matplotlib.pyplot as plt
import PIL
import os
os.chdir("C:\\Users\\Impact\\Desktop\\Melvin\\dmd_control\\DMDController")

callerMode = 'Init';
exeFullFile = 'DMDController\\bin\\Debug\\DMDController.exe'
os.system('cmd /c ' + exeFullFile + " " + callerMode)