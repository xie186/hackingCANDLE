#!/usr/bin/env bash

source /etc/profile.d/modules.sh

# Load the required environment
setup_env () {
  module purge
  # If you want to use Singularity it is recommended you setup a module similar
  # to the included `example_module` and load it as:
  #
  #     module use "/path/to/example_module/modulefiles"
  #     module load singularity rstudio_singularity/3.4.3
  #
  # Bonus points if you install the `example_module` on the system so you don't
  # need to run `module use`.
}
setup_env

# Set up Rstudio env
# TODO: move into modularized setup, take input from form
export RSTUDIO_SINGULARITY_IMAGE=/depot/itap/singularity/singularity-rstudio.simg
export RSTUDIO_SINGULARITY_HOST_MNT=
export RSTUDIO_SINGULARITY_CONTAIN=1
export RSTUDIO_SINGULARITY_HOME=$HOME
export R_LIBS_USER=$HOME/R/library/3.4
export PATH=$PATH:${PWD}/bin

chmod +x ${PWD}/bin/*


#
# Start RStudio Server
#

# PAM auth helper used by RStudio
export RSTUDIO_AUTH="${PWD}/bin/auth"

# Generate an `rsession` wrapper script
export RSESSION_WRAPPER_FILE="${PWD}/rsession.sh"
(
umask 077
sed 's/^ \{2\}//' > "${RSESSION_WRAPPER_FILE}" << EOL
  #!/usr/bin/env bash
  # Log all output from this script
  export RSESSION_LOG_FILE="${RSTUDIO_SINGULARITY_HOST_MNT}${PWD}/rsession.log"
  exec &>>"\${RSESSION_LOG_FILE}"
  # Launch the original command
  echo "Launching rsession..."
  set -x
  exec rsession --r-libs-user "${R_LIBS_USER}" "\${@}"
EOL
)
chmod 700 "${RSESSION_WRAPPER_FILE}"

# Define launcher for `rserver` if not using Singularity
if [[ -z "${RSTUDIO_SINGULARITY_IMAGE}" ]]; then
  PROOT_BIN="${PROOT_BIN:-"/usr/local/proot/bin/proot-x86_64"}"
  RSERVER_LAUNCHER="${PROOT_BIN} -b $(mktemp -d):/tmp "
fi

# Set working directory to home directory
cd "${HOME}"

# Output debug info

# Launch the RStudio Server
echo "Starting up rserver..."
set -x
${RSERVER_LAUNCHER}rserver \
  --www-port ${port} \
  --auth-none 0 \
  --auth-pam-helper-path "${RSTUDIO_SINGULARITY_HOST_MNT}${RSTUDIO_AUTH}" \
  --auth-encrypt-password 0 \
  --rsession-path "${RSTUDIO_SINGULARITY_HOST_MNT}${RSESSION_WRAPPER_FILE}" \
  --auth-minimum-user-id 104
