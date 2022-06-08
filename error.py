import numpy as np
import sys
orig = np.fromfile(sys.argv[1], dtype=np.float32)
decomp = np.fromfile(sys.argv[2], dtype=np.float32)
error = orig - decomp
error.tofile(sys.argv[3])
