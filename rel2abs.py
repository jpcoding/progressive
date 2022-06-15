# /usr/bin/python3

import numpy as np
import sys
file = sys.argv[1]
data = np.fromfile(file,dtype=np.float32)
releb = float(sys.argv[2])
abseb = releb*(np.max(data)-np.min(data))
print('%.6f'%(abseb))


