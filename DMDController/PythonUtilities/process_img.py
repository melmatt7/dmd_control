import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from PIL import Image
# directory = "../../../camera_out/report/"
directory="C:\\Users\\Impact\\Desktop\\Melvin\\camera_out\\report\\"
curr_dir = "C:\\Users\\Impact\\Desktop\\Melvin\\dmd_control\\DMDController\\PythonUtilities\\"
off_directory="C:\\Users\\Impact\\Desktop\\Melvin\\camera_out\\off\\"
off = Image.open(off_directory+"off.png")
off1 = np.asarray(off)
# print(off1.max())
img_norm2=off1/off1.max()
index_y2, index_x2=np.indices(off1.shape)
centroid_x2=np.average(index_x2, weights=img_norm2**5)
centroid_y2=np.average(index_y2, weights=img_norm2**5)

from matplotlib.colors import LinearSegmentedColormap


greiner = { 'red': ((0., 1, 1,), (.2, 0, 0), (.48, 0, 0), (.728, 1, 1), (0.912, 1, 1), (1, .5, .5)),
            'green': ((0., 1, 1), (.2, 0, 0), (.3, 0, 0), (.5, 1, 1), (.712, 1, 1), (.928, 0, 0), (1, 0, 0)),
            'blue':  ((0., 1, 1), (.2, .5, .5), (.288, 1, 1), (.472, 1, 1), (.72, 0, 0), (1, 0, 0)) }
greiner = LinearSegmentedColormap('greiner', greiner, plt.rcParams["image.lut"])

thesis_cm = greiner

for filename in os.listdir(directory):
    print(filename)
    img = Image.open(directory+filename)
    img1 = np.asarray(img)
    # print(img1.max())

    img_norm1=img1/img1.max()
    index_y1, index_x1=np.indices(img1.shape)
    centroid_x1=np.average(index_x1, weights=img_norm1**9)
    centroid_y1=np.average(index_y1, weights=img_norm1**9)
    # print(centroid_x1, centroid_y1)
    
    img = np.zeros((np.shape(img1)[0],np.shape(img1)[1]))
    for i in range(np.shape(img1)[0]):
        for j in range(np.shape(img1)[1]):
            img[i,j] = img1[i,j]/off1[i,j]

    # plt.figure(3)
    img_norm=img/(img.max())
    index_y, index_x=np.indices(img.shape)
    centroid_x=np.average(index_x, weights=img_norm**5)
    centroid_y=np.average(index_y, weights=img_norm**5)
    sm = plt.imshow(img, cmap = thesis_cm)
    
    plt.savefig(curr_dir+filename[:len(filename)-4]+".svg")
    plt.show()



