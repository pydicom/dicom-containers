#!/bin/bash

if [ $# -eq 0 ]; then
    ls /opt/dcmtk361/bin
    echo "You can issue any of the above commands to the container."
    exit 1
else
    exec "$@"
fi

