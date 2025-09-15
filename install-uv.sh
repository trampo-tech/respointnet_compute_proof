#!/bin/bash

# create uv environment
# uv venv -p 3.10
# source .venv/bin/activate

# install dependencies
# uv pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113
# use cuda 12.1 due to compiling issues with cuda 11.3
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
uv pip install scikit-learn IPython scikit-image matplotlib pillow tqdm opencv-python setuptools ipykernel
uv pip install termcolor tensorboard h5py easydict

# install custom operators
cd ops/cpp_wrappers
sh compile_wrappers.sh
cd ../pt_custom_ops
python setup.py install --user
cd ../..