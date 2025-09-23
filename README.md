# [ResPointNet++](https://www.sciencedirect.com/science/article/abs/pii/S0926580521003253) (Automated semantic segmentation of industrial point clouds using ResPointNet++) 

Paper link: [Sciencedirect](https://www.sciencedirect.com/science/article/abs/pii/S0926580521003253) or [ResearchGate](https://www.researchgate.net/publication/353826302_Automated_semantic_segmentation_of_industrial_point_clouds_using_ResPointNet)

by Chao Yin, Boyu Wang, [Vincent J.L.Gan](https://scholar.google.com.hk/citations?user=lBQYX9sAAAAJ&hl=zh-TW), [Mingzhu Wang*](https://www.lboro.ac.uk/departments/abce/staff/mingzhu-wang/), [Jack C.P.Cheng*](https://facultyprofiles.hkust.edu.hk/profiles.php?profile=jack-chin-pang-cheng-cejcheng)

## Abstract

Currently, as-built building information modeling (BIM) models from point clouds show great potential in managing building information. The automatic creation of as-built BIM models from point clouds is important yet challenging due to the inefficiency of semantic segmentation. To overcome this challenge, this paper proposes a novel deep learning-based approach, ResPointNet++, by integrating deep residual learning with conventional PointNet++ network. To unleash the power of deep learning methods, this study firstly builds an expert-labeled high-quality industrial LiDAR dataset containing 80 million data points collected from four different industrial scenes covering nearly 4000 m2. Our dataset consists of five typical semantic categories of plumbing and structural components (i.e., pipes, pumps, tanks, I-shape and rectangular beams). Second, we introduce two effective neural modules including local aggregation operator and residual bottleneck modules to learn complex local structures from neighborhood regions and build up deeper point cloud networks with residual settings. Based on these two neural modules, we construct our proposed network, ResPointNet++, with a U-Net style encoder-decoder structure. To validate the proposed method, comprehensive experiments are conducted to compare the robustness and efficiency of our ResPointNet++ with two representative baseline methods (PointNet and PointNet++) on our benchmark dataset. The experimental results demonstrate that ResPointNet++ outperforms two baselines with a remarkable overall segmentation accuracy of 94% and mIoU of 87%, which is 23% and 42% higher than that of conventional PointNet++, respectively. Finally, ablation studies are performed to evaluate the influence of design choices of the local aggregation operator module including input feature type and aggregation function type. This study contributes to automated 3D scene interpretation of industrial point clouds as well as the as-built BIM creation for industrial components such as pipes and beams.

## System Requirements & Compatibility

**Tested Environments:**
- Ubuntu 18.04/20.04/22.04
- NVIDIA GPUs with CUDA Compute Capability ≥ 6.0
- NVIDIA Driver ≥ 515 (for CUDA 11.7 support)
- Python 3.10
- PyTorch 1.13.1
- CUDA Toolkit 11.7

**Hardware Tested:**
- NVIDIA RTX 3090 (24GB)
- NVIDIA RTX 4090 (24GB)

## Installation

This project supports two installation methods: **Conda** and **UV**. Choose the one that suits your environment.

### Method 1: Conda Installation (Recommended)

```bash
# Run the automated conda installation script
bash install-conda.sh
```

The script will:
- Create a conda environment named `respointnet2` with Python 3.10
- Install PyTorch 1.13.1 with CUDA 11.7 support
- Install all required dependencies
- Compile custom CUDA operators

### Method 2: UV Installation (Modern Python Package Manager)

```bash
# Create and activate uv environment (if not already done)
uv venv -p 3.10
source .venv/bin/activate

# Run the automated uv installation script
bash install-uv.sh
```

### Manual Installation Steps

If you prefer manual installation, here are the key steps:

#### For Conda:
```bash
ENV_NAME='respointnet2'
conda create -n $ENV_NAME python=3.10 -y
conda activate $ENV_NAME

# Install PyTorch with CUDA 11.7 (compatible with newer drivers)
conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.7 -c pytorch -c nvidia

# Install other dependencies
conda install -c conda-forge opencv -y
conda install -c anaconda pillow -y
pip3 install termcolor tensorboard h5py easydict scikit-learn
```

#### For UV:
```bash
# Install PyTorch with CUDA 11.7
uv pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu117

# Install other dependencies
uv pip install scikit-learn IPython scikit-image matplotlib pillow tqdm opencv-python setuptools ipykernel
uv pip install termcolor tensorboard h5py easydict
```

### Compile Custom CUDA Operators

After installing the dependencies, compile the custom operators:

```bash
bash init.sh
```


## PSNet5 dataset

PSNet5 dataset contains 80 million data points collected from four different industrial scenes covering nearly 4000 m^2. Five typical semantic categories of plumbing and structural classes are annotaed, including pipe, pump, tank, I-shape beam (ibeam) and rectangular beam(rbeam).

Click [Onedrive](https://1drv.ms/u/c/f63e74324b55168c/EYwWVUsydD4ggPZKQwAAAAAB7Ncp9Oz6BSyieSOKEkbv0g?e=dgFMgH) or [BaiduYun](https://pan.baidu.com/s/1SzUYkhPgOCru2DB-JwGaSw?pwd=8g2n) to download our dataset, which is about 0.5Gb large and costs about 2.3 Gb after the unzipping.

- download the dataset and unzip the file to `root/data/PSNet`
- The file structure should look like:

```
<root>
├── cfgs
│   └── psnet5
├── data
│   └── PSNet
│       └── PSNet5
│           ├── Area_1
│           ├── Area_2
│           └── ...
├── init.sh
├── datasets
├── function
├── models
├── ops
└── utils
```

- pre-processing the dataset

```bash
python datasets/PSNet5.py
```

## Training

To train the model(s) in the paper, run this command or check the `train-psnet5.sh` for details.

```train
time python -m torch.distributed.launch --master_port 12346 \
--nproc_per_node ${num_gpus} \
function/train_psnet_dist.py \
--dataset_name ${dataset_name} \
--cfg cfgs/${dataset_name}/${config_name}.yaml
```


## Evaluation

To evaluate the model on PSNet5, run this command or check the `train-psnet5.sh`

```eval
time python -m torch.distributed.launch --master_port 12346 \
--nproc_per_node ${num_gpus} \
function/train_psnet_dist.py \
--dataset_name ${dataset_name} \
--cfg cfgs/${dataset_name}/${config_name}.yaml
```

`bash train-psnet5.sh`

## Pre-trained Models

You can download pretrained models here:

- [TOADD](https://drive.google.com/mymodel.pth) trained on the PSNet5

## Troubleshooting

see [troubleshooting.md](troubleshooting.md) for potential issues and solutions.

## Acknowledgements

Our codes borrowed a lot from [CloserLook3D](https://github.com/zeliu98/CloserLook3D), [KPConv-pytorch](https://github.com/HuguesTHOMAS/KPConv-PyTorch), [PointNet](https://github.com/charlesq34/pointnet), [PointNet++](https://github.com/erikwijmans/Pointnet2_PyTorch).

## Our other relevant works

- [SE-PseudoGrid: Automated Classification of Piping Components from 3D LiDAR Point Clouds](https://github.com/PointCloudYC/se-pseudogrid)

## License

Our code is released under MIT License (see LICENSE file for details).

## Citation

If you find our work useful in your research, please consider citing:

```
@article{respointnet2,
    Author = {C. Yin, B. Wang, V. J. L. Gan, M. Wang*, and J. C. P. Cheng*},
    Title = {Automated semantic segmentation of industrial point clouds using ResPointNet++},
    Journal = {Automation in Construction},
    Year = {2021}
    doi = {https://doi.org/10.1016/j.autcon.2021.103874}
   }
```
