#!/bin/bash

if [ $# -eq 0 ]; then
    ls /opt/dcmtk364/bin
    echo "You can issue any of the above commands to the container.";
    echo "explore ipython to find pynetdicom and pydicom as well.";
    exit 1
else
    exec "$@"
fi

