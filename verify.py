import numpy as np
import sys 

orig=np.fromfile(sys.argv[1],dtype=np.float32)

for i in range(len(sys.argv)-2):
    orig=orig-np.fromfile(sys.argv[i+2],dtype=np.float32)

print("maximum error = ",np.max(np.abs(orig)))


