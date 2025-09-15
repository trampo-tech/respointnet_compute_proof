## can not compile ops@250915

- prob.: tittle; reporting 1)nvcc CUDA version was not compatible with pytorch; 2) still errors;
- sol.: make sure your conda environment has a built-in nvcc environment and install a system-wide CUDA toolkit (Note: I already have 12.1 installed, so I need manage cuda toolkit versions)

```bash
# install system-wide CUDA toolkit
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda_11.7.0_515.43.04_linux.run
# only install the toolkit as u already have a newer nvidia driver installed and it also supports cuda 11.7
sudo sh cuda_11.7.0_515.43.04_linux.run --silent --toolkit --toolkitpath=/usr/local/cuda-11.7
# verify the installation
/usr/local/cuda-11.7/bin/nvcc --version

# conda install pytorch and cuda toolkit
conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.7 -c pytorch -c nvidia

# manage cuda toolkit versions 
# way 1 for execute 1 command
CUDA_HOME=/usr/local/cuda-11.7 python setup.py install
# way 2 for execute in a command prompt
export CUDA_HOME=/usr/local/cuda-11.7
export PATH=/usr/local/cuda-11.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH
nvcc --version
# way 3 make the default link to cuda 11.7
# sudo rm /usr/local/cuda
sudo ln -s /usr/local/cuda-11.7 /usr/local/cuda
nvcc --version

# compile ops
bash init.sh
```

- refs
  - gemini chat: https://g.co/gemini/share/18284f7e5948
  - [Managing Multiple CUDA + cuDNN Installations | by YushanT7 | Medium](https://medium.com/@yushantripleseven/managing-multiple-cuda-cudnn-installations-ba9cdc5e2654#31dc), main useful guide, using sh files to install cuda toolkit.
  - [Managing multiple CUDA versions using environment modules in Ubuntu](https://gist.github.com/garg-aayush/156ec6ddda3d62e2c0ddad00b7e66956), good guide, using deb files to install cuda toolkit.
  - [pointnet2\_ops install problem · Issue #174 · erikwijmans/Pointnet2\_PyTorch](https://github.com/erikwijmans/Pointnet2_PyTorch/issues/174)
  - [CUDA Installation Guide for Linux — Installation Guide for Linux 13.0 documentation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#installing-cuda-using-conda)
  - [Previous PyTorch Versions](https://pytorch.org/get-started/previous-versions/)