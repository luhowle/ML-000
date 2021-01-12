# distutils: language=c++
# Commented out IPython magic to ensure Python compatibility.
# %%cython --cplus -a


cimport cython
import numpy as np
cimport numpy as np

from libcpp.vector cimport vector
from libcpp.unordered_map cimport unordered_map

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef calc_mean_v3(data,y_name,x_name):

    cdef int n = data.shape[0]

    cdef vector[int] vecx = data.x
    cdef vector[int] vecy = data.y
    cdef vector [double] vecresult

    cdef np.ndarray [double]  npresult = np.zeros(n)


    cdef unordered_map[int,double] ddsum
    cdef unordered_map[int,double] ddcount


    for i in xrange(n):

        ddsum[vecx[i]] = vecy[i] + ddsum[vecx[i]]
        ddcount[vecx[i]] = ddcount[vecx[i]] + 1

    for i in xrange(n):

        npresult[i] = (((ddsum[vecx[i]]- vecy[i]) / (ddcount[vecx[i]] - 1)))

    return npresult
