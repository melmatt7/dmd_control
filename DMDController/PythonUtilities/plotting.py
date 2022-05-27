import matplotlib.pyplot as plt
import numpy as np
import scipy as sp
import pandas as pd
import seaborn as sns #library to make the plots look fancy
from matplotlib.ticker import MultipleLocator
from scipy.io import loadmat  # this is the SciPy module that loads mat-files

# for tutorials look here: https://seaborn.pydata.org/tutorial.html

sns.set_style("whitegrid")
results_path = "C:\\Users\\Impact\\Desktop\\Melvin\\dmd_control\\raw_results\\picoscope\\fourier\\"
name = "140k"
file = results_path + name + ".mat"

save_path = "C:\\Users\\Impact\\Desktop\\Melvin\\dmd_control\\DMDController\\PythonUtilities\\fourier_results\\"

data = loadmat(file_name=file)

print(int(data["Tstart"][0][0]))

# for i,a in enumerate(data["A"]):
#     if a > 0.009:
#         data["A"][i] = a*1.1
#     else:
#         data["A"][i] = a
        
# for j,b in enumerate(data["B"]):
#     if b < 0.01 and b > 0.0075:
#         data["B"][j] = b*0.8
#     else:
#         data["B"][j] = b
        
time = np.linspace(data["Tstart"][0][0],data["Length"][0][0]*data["Tinterval"][0][0],int(data["Length"][0][0]))
print(time)
# plt.ylim(0.0065,0.012)
plt.xlim(0,0.2e6)
plt.plot(time, data["A"])
# plt.plot(time, data["B"])
# plt.plot(time, data["C"])
plt.savefig(save_path+name+".svg")
plt.show()
    
# Manually set your data like this
#t = np.linspace(0,6*np.pi,1000)
#voltage = np.sin(t)
#data = {'Time':t, 'Voltage':voltage}

# Read data from a csv
# pd.write_csv()
# data = pd.read_csv("../../../picoscope/1k_single.csv", header=0, names=["time", "channel A"])

# # This is how you scale data
# # data["frequency"] = data["frequency"]*1e-9


# fig = plt.figure()

# # Height and aspect can be used to set the aspect ratio
# g = sns.relplot(data=data, x="voltage", y="frequency", kind="line", height=6, aspect=1.5)


# # Use this if you want to set custom grid spacing
# g.axes[0][0].yaxis.set_major_locator(MultipleLocator(0.5))

# # Axes labels
# plt.xlabel("Voltage [V]")
# plt.ylabel("Frequency [Hz]")

# # Set your name here
# plt.savefig("1k_single.pngimp")