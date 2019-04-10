#!/usr/bin/env bash

source /etc/profile.d/modules.sh


echo "Starting main script..."
echo "TTT - $(date)"

#
# Start Jupyter Notebook server
#

# Clean the environment
module purge

# Create launcher wrapper
echo "Creating launcher wrapper script..."
(
umask 077
sed 's/^ \{2\}//' > "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.sh" << EOL
  #!/usr/bin/env bash
  # Log all output from this script
  exec &>>"/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.log"
  # Load the required environment
  module purge
  module load \${MODULES}
  module list
  # Launch the original command
  set -x
  exec "\${@}"
EOL
)
chmod 700 "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.sh"
echo "TTT - $(date)"

# Create custom Jupyter kernels
echo "Creating custom Jupyter kernels..."
export JUPYTER_PATH="${PWD}/share/jupyter"
mkdir -p "${JUPYTER_PATH}/kernels/sys_python36"
cp "${PWD}/assets/python"/* "${JUPYTER_PATH}/kernels/sys_python36/."
(
umask 077
cat > "${JUPYTER_PATH}/kernels/sys_python36/kernel.json" << EOL
{
  "display_name": "Python 3.6 [anaconda/5.1.0-py36]",
  "language": "python",
  "argv": [
    "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.sh",
    "python",
    "-m",
    "ipykernel_launcher",
    "-f",
    "{connection_file}"
  ],
  "env": {
    "MODULES": "anaconda/5.1.0-py36"
  }
}
EOL
)
mkdir -p "${JUPYTER_PATH}/kernels/sys_python27"
cp "${PWD}/assets/python"/* "${JUPYTER_PATH}/kernels/sys_python27/."
(
umask 077
cat > "${JUPYTER_PATH}/kernels/sys_python27/kernel.json" << EOL
{
  "display_name": "Python 2.7 [anaconda/5.1.0-py27]",
  "language": "python",
  "argv": [
    "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.sh",
    "python",
    "-m",
    "ipykernel",
    "-f",
    "{connection_file}"
  ],
  "env": {
    "MODULES": "anaconda/5.1.0-py27"
  }
}
EOL
)
mkdir -p "${JUPYTER_PATH}/kernels/sys_learning36"
cp "${PWD}/assets/learning"/* "${JUPYTER_PATH}/kernels/sys_learning36/."
(
umask 077
cat > "${JUPYTER_PATH}/kernels/sys_learning36/kernel.json" << EOL
{
  "display_name": "Python 3.6 - Learning [learning/conda-5.1.0-py36-gpu]",
  "language": "python",
  "argv": [
    "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.sh",
    "python",
    "-m",
    "ipykernel",
    "-f",
    "{connection_file}"
  ],
  "env": {
    "MODULES": "learning/conda-5.1.0-py36-gpu ml-toolkit-gpu/opencv  ml-toolkit-gpu/keras  ml-toolkit-gpu/pytorch ml-toolkit-gpu/tensorflow  ml-toolkit-gpu/tflearn ml-toolkit-gpu/gym  ml-toolkit-gpu/cntk   ml-toolkit-gpu/theano ml-toolkit-gpu/gym"
  }
}
EOL
)
mkdir -p "${JUPYTER_PATH}/kernels/sys_learning27"
cp "${PWD}/assets/learning"/* "${JUPYTER_PATH}/kernels/sys_learning27/."
(
umask 077
cat > "${JUPYTER_PATH}/kernels/sys_learning27/kernel.json" << EOL
{
  "display_name": "Python 2.7 - Learning [learning/conda-5.1.0-py27-gpu]",
  "language": "python",
  "argv": [
    "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.sh",
    "python",
    "-m",
    "ipykernel",
    "-f",
    "{connection_file}"
  ],
  "env": {
    "MODULES": "learning/conda-5.1.0-py27-gpu  ml-toolkit-gpu/opencv  ml-toolkit-gpu/keras  ml-toolkit-gpu/pytorch ml-toolkit-gpu/tensorflow  ml-toolkit-gpu/tflearn ml-toolkit-gpu/gym  ml-toolkit-gpu/cntk   ml-toolkit-gpu/theano ml-toolkit-gpu/gym"
  }
}
EOL
)
echo "TTT - $(date)"

# Create user-created Conda env Jupyter kernels
echo "Creating custom Jupyter kernels from user-created Conda environments..."
for dir in "${HOME}/.conda/envs"/*/ "${HOME}/envs"/*/ ; do
  (
  umask 077
  set -e
  KERNEL_NAME="$(basename "${dir}")"
  KERNEL_PATH="~${dir#${HOME}}"
  [[ -x "${dir}bin/activate" ]] || exit 0
  echo "Creating kernel for ${dir}..."
  source "${dir}bin/activate" "${dir}"
  set -x
  if [[ "$(conda list -f --json ipykernel)" == "[]" ]]; then
    CONDA_PKGS_DIRS="$(mktemp -d)" conda install --yes --quiet --no-update-deps ipykernel
  fi
  python \
    -m ipykernel \
      install \
      --name "conda_${KERNEL_NAME}" \
      --display-name "${KERNEL_NAME} [${KERNEL_PATH}]" \
      --prefix "${PWD}"
  ) &
done
wait
echo "TTT - $(date)"

# Set working directory to notebook root directory
cd "${NOTEBOOK_ROOT}"

# Setup Jupyter Notebook environment
#module use $MODULEPATH_ROOT/project/ondemand
#module load jupyter/python3.5
module load anaconda
module list
echo "TTT - $(date)"

# List available kernels for debugging purposes
set -x
jupyter kernelspec list
{ set +x; } 2>/dev/null
echo "TTT - $(date)"

# Launch the Jupyter Notebook server
set -x
jupyter notebook --config="${CONFIG_FILE}"
