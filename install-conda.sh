#!/bin/bash
set -e  # Stop script immediately if any command fails

ENV_NAME='respointnet2'

# Ensure conda commands work inside bash scripts
eval "$(conda shell.bash hook)"

# 1. Create and activate environment
conda create -n "$ENV_NAME" python=3.10 pip numpy -y
conda activate "$ENV_NAME"

# 2. PyTorch and core dependencies (CUDA 11.7)
conda install -y -c pytorch -c nvidia \
    pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.7

# 3. Vision & pinned MKL dependencies
conda install -y -c conda-forge opencv
conda install -y -c anaconda pillow
conda install -y mkl=2021.4.0 intel-openmp=2021.4.0

# 4. Pin setuptools for numpy.distutils and install remaining python packages
pip install "setuptools<60" termcolor tensorboard h5py easydict scikit-learn

# 5. CUDA 11.7 dev tools & GCC 11 compiler suite
conda install -y -c nvidia \
    cuda-nvcc=11.7 \
    cuda-cudart-dev=11.7 \
    cuda-cccl=11.7 \
    libcusparse-dev \
    libcublas-dev \
    libcusolver-dev \
    libcurand-dev

conda install -y -c conda-forge \
    gcc_linux-64=11.4.0 \
    gxx_linux-64=11.4.0

# Export compiler flags and paths
export CC="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-gcc"
export CXX="$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-g++"
export CUDA_HOME="$CONDA_PREFIX"
export TORCH_CUDA_ARCH_LIST="8.6"

# 6. Install custom operators
cd ops/cpp_wrappers
rm -rf build *.so
sh compile_wrappers.sh

cd ../pt_custom_ops
rm -rf build dist *.egg-info
python setup.py install --user
cd ../..

