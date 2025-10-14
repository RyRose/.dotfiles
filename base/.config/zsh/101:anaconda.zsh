# Add anaconda binaries to PATH.
export PATH="$PATH:$HOME/anaconda3/bin"

# Add CUDA config for ML work.
export CUDA_DIR="$HOME/anaconda3/nvvm"
export XLA_FLAGS="--xla_gpu_cuda_data_dir=$CUDA_DIR"
