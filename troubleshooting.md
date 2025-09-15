## Troubleshooting CUDA Compilation Issues

If you encounter CUDA compilation errors, follow these solutions:

### Issue 1: CUDA Version Mismatch

**Problem:** `RuntimeError: The detected CUDA version (X.X) mismatches the version that was used to compile PyTorch (Y.Y)`

**Solution:** Install system-wide CUDA toolkit that matches PyTorch:

```bash
# Download and install CUDA 11.7 toolkit
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda_11.7.0_515.43.04_linux.run

# Install only the toolkit (if you already have compatible drivers)
sudo sh cuda_11.7.0_515.43.04_linux.run --silent --toolkit --toolkitpath=/usr/local/cuda-11.7

# Verify installation
/usr/local/cuda-11.7/bin/nvcc --version
```

### Issue 2: Multiple CUDA Versions

**Problem:** System has multiple CUDA versions installed

**Solution:** Set environment variables to use CUDA 11.7:

```bash
# Method 1: Set for current session
export CUDA_HOME=/usr/local/cuda-11.7
export PATH=/usr/local/cuda-11.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH

# Method 2: Make CUDA 11.7 the default (requires sudo)
sudo ln -sf /usr/local/cuda-11.7 /usr/local/cuda

# Verify
nvcc --version
```

### Issue 3: Architecture-Specific Compilation

**Problem:** CUDA architecture not supported

**Solution:** Set the appropriate CUDA architecture:

```bash
# For RTX 30xx series (Ampere)
export TORCH_CUDA_ARCH_LIST="8.6"

# For RTX 40xx series (Ada Lovelace)
export TORCH_CUDA_ARCH_LIST="8.9"

# For multiple architectures
export TORCH_CUDA_ARCH_LIST="6.1;7.5;8.6;8.9"
```

### Complete Troubleshooting Workflow

If compilation still fails, try this systematic approach:

```bash
# 1. Clean previous builds
cd ops/cpp_wrappers/cpp_subsampling
rm -rf build/
cd ../pt_custom_ops
rm -rf build/

# 2. Set CUDA environment (adjust path as needed)
export CUDA_HOME=/usr/local/cuda-11.7
export PATH=/usr/local/cuda-11.7/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH

# 3. Verify CUDA and PyTorch compatibility
nvcc --version
python -c "import torch; print(f'PyTorch: {torch.__version__}, CUDA: {torch.version.cuda}')"

# 4. Compile with verbose output
cd /path/to/ResPointNet2
CUDA_HOME=/usr/local/cuda-11.7 bash init.sh
```

For more detailed troubleshooting information, see [`yc/faq.md`](yc/faq.md).

### Installation Verification

After successful installation, verify everything is working:

```bash
# Activate your environment
conda activate respointnet2  # for conda
# OR
source .venv/bin/activate     # for uv

# Test PyTorch and CUDA
python -c "import torch; print(f'PyTorch: {torch.__version__}, CUDA available: {torch.cuda.is_available()}, CUDA version: {torch.version.cuda}')"

# Test custom operators (should run without errors)
cd ops/cpp_wrappers/cpp_subsampling
python -c "import grid_subsampling; print('C++ operators: OK')"

cd ../pt_custom_ops
python -c "import pt_custom_ops; print('PyTorch CUDA operators: OK')"
```

Expected output:
```
PyTorch: 1.13.1+cu117, CUDA available: True, CUDA version: 11.7
C++ operators: OK
PyTorch CUDA operators: OK
```