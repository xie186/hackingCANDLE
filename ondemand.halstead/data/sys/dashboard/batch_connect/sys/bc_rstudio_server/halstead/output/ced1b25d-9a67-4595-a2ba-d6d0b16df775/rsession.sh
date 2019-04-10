#!/usr/bin/env bash
# Log all output from this script
export RSESSION_LOG_FILE="/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/rsession.log"
exec &>>"${RSESSION_LOG_FILE}"
# Launch the original command
echo "Launching rsession..."
set -x
exec rsession --r-libs-user "/home/xie186/R/library/3.4" "${@}"
