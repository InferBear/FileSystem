#!/bin/bash

SCRATCH=$(mktemp -d)
trap "rm -fr $SCRATCH" INT QUIT TERM EXIT

# Test: data/image.5

cp data/image.5 $SCRATCH/image.5
cat <<EOF | ./bin/sfssh $SCRATCH/image.5 5 > /dev/null 2>&1
debug
mount
copyout 1 $SCRATCH/1.txt
create
debug
copyin $SCRATCH/1.txt 0
debug
copyout 0 $SCRATCH/1.copy
EOF
echo -n "Testing copyin in $SCRATCH/image.5 ... "
if [ $(md5sum $SCRATCH/1.copy | awk '{print $1}') = '1edec6bc701059c45053cf79e7e16588' ]; then
    echo "Success"
else
    echo "Failure"
fi

# Test: data/image.20

cp data/image.20 $SCRATCH/image.20
cat <<EOF | ./bin/sfssh $SCRATCH/image.20 20 > /dev/null 2>&1
debug
mount
copyout 2 $SCRATCH/2.txt
copyout 3 $SCRATCH/3.txt
create
copyin $SCRATCH/3.txt 0
create
copyin $SCRATCH/2.txt 1
copyout 0 $SCRATCH/3.copy
copyout 1 $SCRATCH/2.copy
debug
EOF
echo -n "Testing copyin in $SCRATCH/image.20 ... "
if [ $(md5sum $SCRATCH/2.copy | awk '{print $1}') = '1adf08d52e0f1a162a3a887a19fcf1f8' ] &&
   [ $(md5sum $SCRATCH/3.copy | awk '{print $1}') = 'd083a4be9fde347b98a8dbdfcc196819' ]; then
    echo "Success"
else
    echo "Failure"
fi

# Test: data/image.200

cp data/image.200 $SCRATCH/image.200
cat <<EOF | ./bin/sfssh $SCRATCH/image.200 200 > /dev/null 2>&1
debug
mount
copyout 1 $SCRATCH/1.txt
copyout 2 $SCRATCH/2.txt
copyout 9 $SCRATCH/9.txt
create
copyin $SCRATCH/1.txt 0
create
copyin $SCRATCH/2.txt 3
create
copyin $SCRATCH/9.txt 4
debug
copyout 0 $SCRATCH/1.copy
copyout 3 $SCRATCH/2.copy
copyout 4 $SCRATCH/9.copy
EOF
echo -n "Testing copyin in $SCRATCH/image.200 ... "
if [ $(md5sum $SCRATCH/1.copy | awk '{print $1}') = '0af623d6d8cb0a514816e17c7386a298' ] &&
   [ $(md5sum $SCRATCH/2.copy | awk '{print $1}') = '307fe5cee7ac87c3b06ea5bda80301ee' ] &&
   [ $(md5sum $SCRATCH/9.copy | awk '{print $1}') = 'fa4280d88da260281e509296fd2f3ea2' ]; then
    echo "Success"
else
    echo "Failure"
fi
