#!/usr/bin/env bash

source /etc/profile.d/modules.sh

# Clean the environment
module purge

# Set working directory to home directory
cd "${HOME}"

#
# Launch Xfce Window Manager and Panel
#

#(
#  export SEND_256_COLORS_TO_REMOTE=1
#  export XDG_CONFIG_HOME="/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_windows/halstead/output/27d787b2-6d54-4e68-b34c-c468ecc05f4d/config"
#  export XDG_DATA_HOME="/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_windows/halstead/output/27d787b2-6d54-4e68-b34c-c468ecc05f4d/share"
#  export XDG_CACHE_HOME="$(mktemp -d)"
#  module restore
#  set -x
#  xfwm4 --compositor=off --daemon --sm-client-disable
#  xsetroot -solid "#D3D3D3"
#  xfsettingsd --sm-client-disable
#  xfce4-panel --sm-client-disable
#) &

set +x

# Load the required environment
module load qemu

IMG=/scratch/halstead/${USER:0:1}/$USER/windows-base.qcow2

SRCIMG=/depot/itap/windows/base/2k16.qcow2

if [[ ! -e $IMG ]]; then
	echo "Copying source image"
	set +x
	cp $SRCIMG $IMG
fi

set +x
windows -i $IMG -b

pid=`ps aux | grep qemu-system-x86_64 | grep -v grep | awk '{ print $2 }'`

# Start websockify
singularity exec /depot/itap/ddietz/singularity/centos7-xfce4.img /usr/bin/websockify -D $port localhost:5901

# Wait until qemu exits
while true
do
	ps aux | grep qemu-system-x86_64 | grep " $pid " -q 
	if [[ $? -ne 0 ]]; then
		break
	fi
	sleep 1
done
