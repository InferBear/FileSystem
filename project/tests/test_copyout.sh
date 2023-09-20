#!/bin/bash

SCRATCH=$(mktemp -d)
trap "rm -fr $SCRATCH" INT QUIT TERM EXIT

# Test: data/image.5

echo -n "Testing copyout in data/image.5 ... "
cat <<EOF | ./bin/sfssh data/image.5 5 > /dev/null 2>&1
mount
copyout 1 $SCRATCH/1.txt
EOF
if [ $(md5sum $SCRATCH/1.txt | awk '{print $1}') = '1edec6bc701059c45053cf79e7e16588' ]; then
    echo "Success"
else
    echo "Failure"
fi

# Test: data/image.20

cat <<EOF | ./bin/sfssh data/image.20 20 > /dev/null 2>&1
mount
copyout 2 $SCRATCH/2.txt
copyout 3 $SCRATCH/3.txt
EOF

echo -n "Testing copyout in data/image.20 ... "
if [ $(md5sum $SCRATCH/2.txt | awk '{print $1}') = 'bfd6a31563edfd2a943edc29c37366b1' ] &&
   [ $(md5sum $SCRATCH/3.txt | awk '{print $1}') = 'd083a4be9fde347b98a8dbdfcc196819' ]; then
    echo "Success"
else
    echo "Failure"
fi

# Test: data/image.200

cat <<EOF | ./bin/sfssh data/image.200 200 > /dev/null 2>&1
mount
copyout 1 $SCRATCH/1.txt
copyout 2 $SCRATCH/2.txt
copyout 9 $SCRATCH/9.txt
EOF

echo -n "Testing copyout in data/image.200 ... "
if [ $(md5sum $SCRATCH/1.txt | awk '{print $1}') = '0af623d6d8cb0a514816e17c7386a298' ] &&
   [ $(md5sum $SCRATCH/2.txt | awk '{print $1}') = '307fe5cee7ac87c3b06ea5bda80301ee' ] &&
   [ $(md5sum $SCRATCH/9.txt | awk '{print $1}') = 'cc4e48a5fe0ba15b13a98b3fd34b340e' ]; then
    echo "Success"
else
    echo "Failure"
fi
