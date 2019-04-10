
cd /home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775

# Export useful connection variables
export host
export port

# Generate a connection yaml file with given parameters
create_yml () {
  echo "Generating connection YAML file..."
  (
    umask 077
    echo -e "host: $host\nport: $port\npassword: $password" > "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/connection.yml"
  )
}

# Cleanliness is next to Godliness
clean_up () {
  echo "Cleaning up..."
  [[ -e "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/clean.sh" ]] && source "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/clean.sh"
  [[ ${SCRIPT_PID} ]] && pkill -P ${SCRIPT_PID} || :
  pkill -P $$
  exit ${1:-0}
}

# Source in all the helper functions
source_helpers () {
  # Generate random integer in range [$1..$2]
  random_number () {
    shuf -i ${1}-${2} -n 1
  }
  export -f random_number

  # Check if port $1 is in use
  port_used () {
    local port="${1#*:}"
    local host=$((expr "${1}" : '\(.*\):' || echo "localhost") | awk 'END{print $NF}')
    nc -w 2 "${host}" "${port}" < /dev/null &> /dev/null
  }
  export -f port_used

  # Find available port in range [$2..$3] for host $1
  # Default: [2000..65535]
  find_port () {
    local host="${1:-localhost}"
    local port=$(random_number "${2:-2000}" "${3:-65535}")
    while port_used "${host}:${port}"; do
      port=$(random_number "${2:-2000}" "${3:-65535}")
    done
    echo "${port}"
  }
  export -f find_port

  # Wait $2 seconds until port $1 is in use
  # Default: wait 30 seconds
  wait_until_port_used () {
    local port="${1}"
    local time="${2:-30}"
    for ((i=1; i<=time*2; i++)); do
      if port_used "${port}"; then
        return 0
      fi
      sleep 0.5
    done
    return 1
  }
  export -f wait_until_port_used

  # Generate random alphanumeric password with $1 (default: 8) characters
  create_passwd () {
    tr -cd 'a-zA-Z0-9' < /dev/urandom 2> /dev/null | head -c${1:-8}
  }
  export -f create_passwd
}
export -f source_helpers

source_helpers

# Set host of current machine
host=$(hostname)

[[ -e "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/before.sh" ]] && source "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/before.sh"

echo "Script starting..."
"/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/script.sh" &
SCRIPT_PID=$!

[[ -e "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/after.sh" ]] && source "/home/xie186/ondemand.halstead/data/sys/dashboard/batch_connect/sys/bc_rstudio_server/halstead/output/ced1b25d-9a67-4595-a2ba-d6d0b16df775/after.sh"

# Create the connection yaml file
create_yml

# Wait for script process to finish
wait ${SCRIPT_PID} || clean_up 1

# Exit cleanly
clean_up


