import pyvisa
from keysight_33250a import keysight_33250a
import time 

rm = pyvisa.ResourceManager()
print(rm.list_resources())
# print(rm.list_resources())
arb = keysight_33250a(rm.open_resource('ASRL5::INSTR'))

arb.k33250a.write('("*IDN?')
time.sleep(2)
print(arb.k33250a.read())
# get_unique_scpi_list is a list of SCPI commands which are different from Power-On values
#print(arb.get_all_scpi_list())