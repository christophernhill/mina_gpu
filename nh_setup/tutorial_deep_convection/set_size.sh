#!/bin/bash
#
# Script to change domain size (in horizontal )
#
#
# x-dimensions (nSx - tile size in X, sNx - X tiles per proc, nPx - procs in X)
nSx=100
sNx=4
nPx=1
# y-dimensions (nSy - tile size in Y, sNy - Y tiles per proc, nPy - procs in Y)
nSy=100
sNy=4
nPy=1

nx=$((nSx*sNx*nPx))
ny=$((nSy*sNy*nPy))

echo "nx="${nx}
echo "ny="${ny}

eval "echo \"$(cat gendata.m.template)\"" > input/gendata.m
eval "echo \"$(cat SIZE.h.template)\""    > code/SIZE.h

( cd input; echo "exit" | matlab -nodisplay -nosplash -r gendata )
( cd build; make -j 4                                            )
( cd run; ../build/mitgcmuv > output.txt                         )
