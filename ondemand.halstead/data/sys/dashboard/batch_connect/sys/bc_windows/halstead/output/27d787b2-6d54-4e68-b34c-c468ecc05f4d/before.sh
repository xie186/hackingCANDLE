# Export the module function if it exists
[[ $(type -t module) == "function" ]] && export -f module

port=`find_port`
export port

password=`create_passwd`
export password
export VNC_PASSWORD="${password}"
