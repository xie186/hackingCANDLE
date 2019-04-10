#!/usr/bin/env bash
# Log all output from this script
exec &>>"/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_jupyter/halstead/output/565c8654-2da7-4cad-995f-f27444645941/launch_wrapper.log"
# Load the required environment
module purge
module load ${MODULES}
module list
# Launch the original command
set -x
exec "${@}"
