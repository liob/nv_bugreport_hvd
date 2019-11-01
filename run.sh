#!/bin/bash

set -e

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

NV_GPU=3,4


N_PROCESSES=$(awk -F '[\t,]' '{print NF-1}' <<< "$NV_GPU\n")
let "N_PROCESSES=N_PROCESSES+1"


echo -e "\n\n\n"
echo "======================================="
echo "= nvcr.io/nvidia/tensorflow:19.06-py3 ="
echo "======================================="
echo -e "\n\n\n"

NV_GPU=$NV_GPU nvidia-docker run -it --rm \
    -v "$SCRIPTPATH":"/workspace" \
    nvcr.io/nvidia/tensorflow:19.06-py3 \
    /bin/bash -c "\
        mpirun \
          --allow-run-as-root \
          -x NCCL_DEBUG=INFO \
          --oversubscribe \
          --bind-to none \
          -np $N_PROCESSES \
          python bugreport_hvd.py"



echo -e "\n\n\n"
echo "======================================="
echo "= nvcr.io/nvidia/tensorflow:19.09-py3 ="
echo "======================================="
echo -e "\n\n\n"

NV_GPU=$NV_GPU nvidia-docker run -it --rm \
    -v "$SCRIPTPATH":"/workspace" \
    nvcr.io/nvidia/tensorflow:19.09-py3 \
    /bin/bash -c "\
        mpirun \
          --allow-run-as-root \
          -x NCCL_DEBUG=INFO \
          --oversubscribe \
          --bind-to none \
          -np $N_PROCESSES \
          python bugreport_hvd.py"