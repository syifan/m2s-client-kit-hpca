#!/bin/bash

CONFIG="$1"
CLUSTERNAME=hetero_"$CONFIG"
USERNAME=amir
SERVER=nyan.ece.neu.edu
BENCHMARKSUITE=AMDAPP-2.5
M2S=~/m2s-client-kit/config/"$CONFIG"/m2s

SIMCOMMAND="--si-sim detailed --si-config si-config.ini \
            --mem-config mem-si.ini --net-config net-si.ini \
            --mem-report mem.ref --net-report net.ref \
            --si-report si.ref \
            --mem-snapshot 1000000 4096 \
            --net-snapshot 100000 \
	    --net-visual net_vis.txt"
SENDFILELIST="../config/"$CONFIG"/si-config.ini \
              ../config/"$CONFIG"/mem-si.ini \
              ../config/"$CONFIG"/net-si.ini"


./m2s-cluster.sh kill $CLUSTERNAME
./m2s-cluster.sh remove $CLUSTERNAME
./m2s-cluster.sh create $CLUSTERNAME

JOBNAME=BSch
BENCHCOMMAND="-q -x 2097152"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/BlackScholes \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=DCT
BENCHCOMMAND="-q -x 1024 -y 1024 -i 10"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/DCT \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=DH
BENCHCOMMAND="-q -x 2097152"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/DwtHaar1D \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=FW
BENCHCOMMAND="-q -x 256 -i 5"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/FloydWarshall \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=FWT
BENCHCOMMAND="-q -x 262144 -i 10"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/FastWalshTransform \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=Hist
BENCHCOMMAND="-q -x 2048 -y 2048"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/Histogram \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=MM
BENCHCOMMAND="-q -x 1024 -y 1024 -z 1024"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/MatrixMultiplication \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=MT
BENCHCOMMAND="-q -x 1024 -y 1024 -b 64"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/MatrixTranspose \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=MTw
BENCHCOMMAND="-q -x 131072 -y 4"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/MersenneTwister \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"
   
JOBNAME=RD
BENCHCOMMAND="-q -x 2097152"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/Reduction \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=RS
BENCHCOMMAND="-q -x 2097152"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/RadixSort \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=SC
BENCHCOMMAND="-q -x 512 -y 512 -m 16"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/SimpleConvolution \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=SF
BENCHCOMMAND="-q -x 6.bmp -i 5"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/SobelFilter \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"

JOBNAME=SLA
BENCHCOMMAND="-q -x 2097152"
./m2s-cluster.sh add $CLUSTERNAME "$JOBNAME" \
    $BENCHMARKSUITE/ScanLargeArrays \
    --sim-args "$SIMCOMMAND" \
    --send "$SENDFILELIST" \
    --bench-args "$BENCHCOMMAND"


./m2s-cluster.sh submit $CLUSTERNAME $USERNAME@$SERVER --exe $M2S
