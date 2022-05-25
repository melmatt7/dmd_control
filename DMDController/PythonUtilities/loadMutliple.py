import os
import numpy as np
import matplotlib.pyplot as plt
import PIL
import os
os.chdir("C:\\Users\\Impact\\Desktop\\Melvin\\dmd_control\\DMDController")

r = 'DMDController\\data\\r.bmp'
l = 'DMDController\\data\\l.bmp'
t = 'DMDController\\data\\t.bmp'
b = 'DMDController\\data\\b.bmp'
off = 'DMDController\\data\\off.bmp'
on = 'DMDController\\data\\left.bmp'
right = 'DMDController\\data\\right.bmp'
left = 'DMDController\\data\\left.bmp'
kirby = 'DMDController\\data\\download.bmp'

tsmalll = 'DMDController\\data\\tsmalll.bmp'
tsmallr = 'DMDController\\data\\tsmallr.bmp'

######## ON OFF #########
# h = np.ones((768, 1024), dtype=bool)
# img = PIL.Image.fromarray(h)
# img.save(off,bits=1,optimize=True)

# h = np.zeros((768, 1024), dtype=bool)
# img = PIL.Image.fromarray(h)
# img.save(on,bits=1,optimize=True)


######## R L #########
# h = np.ones((768, 1024), dtype=bool)
# h[:,590:670] = 0
# img = PIL.Image.fromarray(h)
# img.save(r,bits=1,optimize=True)
# # plt.imsave('DMDController\\data\\l.bmp', h, cmap='gray')


######## T B #########
h = np.ones((96, 1024), dtype=bool)
h[:90,700:800] = 0
img = PIL.Image.fromarray(h)
img.save(b,bits=1,optimize=True)

h = np.ones((96, 1024), dtype=bool)
h[:90,900:1000] = 0
img = PIL.Image.fromarray(h)
img.save(t,bits=1,optimize=True)


h = np.ones((90, 1024), dtype=bool)
h[:,:500] = 0
img = PIL.Image.fromarray(h)
img.save(tsmalll,bits=1,optimize=True)

h = np.ones((90, 1024), dtype=bool)
h[:,:] = 0
img = PIL.Image.fromarray(h)
img.save(tsmallr,bits=1,optimize=True)

callerMode = 'Init';
exeFullFile = 'DMDController\\bin\\Debug\\DMDController.exe'
os.system('cmd /c ' + exeFullFile + " " + callerMode)

callerMode = 'MultiLoad'
exeFullFile = 'DMDController\\bin\\Debug\\DMDController.exe'

delineate = ','

# patFiles = right+delineate+left
# patFiles = kirby+delineate+off
# patFiles = r+delineate+l
# patFiles = t+delineate+b
# patFiles = off
patFiles = t+delineate+b
print(patFiles)

os.system('cmd /c ' + exeFullFile + " " + callerMode + " " + patFiles)

print(patFiles)

os.system('cmd /c ' + exeFullFile + " " + callerMode + " " + patFiles)