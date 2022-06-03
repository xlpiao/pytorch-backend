# Convolution
- This directory includes convolution implementation with different programming languages
  - Python(PyTorch, Tensorflow, Numpy), C/C++, and CUDA
- Parameters stride, padding, dilation are also taken into account
- 1D, 2D, and 3D convolution are all included

# Guideline
```
./init.sh             -- Help Message
./init.sh docker      -- Run Docker
./init.sh docker gpu  -- Run Docker with GPU Support
./init.sh build       -- Build Native Code Bind To Python
./init.sh run         -- Run Test Code
./init.sh clean       -- Clean Build Output
./init.sh nvprof      -- Profile With Nvprof
```

