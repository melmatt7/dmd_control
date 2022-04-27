import os
os.chdir("C:\\Users\\Impact\\Desktop\\Melvin\\dmd_control\\DMDController")

callerMode = 'Init';
exeFullFile = 'DMDController\\bin\\Debug\\DMDController.exe'
os.system('cmd /c ' + exeFullFile + " " + callerMode)

callerMode = 'mult'
exeFullFile = 'DMDController\\bin\\Debug\\DMDController.exe'



patFile1 = 'DMDController\\data\\right.bmp'
patFile2 = 'DMDController\\data\\left.bmp'
patFile3 = 'DMDController\\data\\right.bmp'
patFile4 = 'DMDController\\data\\left.bmp'
patFile5 = 'DMDController\\data\\right.bmp'
patFile6 = 'DMDController\\data\\left.bmp'

delineate = ','

# patFiles = patFile1+delineate+patFile2
patFiles = patFile1+delineate+patFile2+delineate+patFile3+delineate+patFile4+delineate+patFile5+delineate+patFile6
print(patFiles)

os.system('cmd /c ' + exeFullFile + " " + callerMode + " " + patFiles)