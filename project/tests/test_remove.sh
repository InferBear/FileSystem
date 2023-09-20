#!/bin/bash

SCRATCH=$(mktemp -d)

# Test 0

test-0-input() {
    echo debug
    echo mount
    echo create
    echo create
    echo create
    echo remove 0
    echo debug
    echo create
    echo remove 0
    echo remove 0
    echo remove 1
    echo remove 3
    echo debug
}

test-0-output() {
    cat <<EOF
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 1:
    size: 965 bytes
    direct blocks: 2
disk mounted.
created inode 0.
created inode 2.
created inode 3.
removed inode 0.
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 1:
    size: 965 bytes
    direct blocks: 2
Inode 2:
    size: 0 bytes
    direct blocks:
Inode 3:
    size: 0 bytes
    direct blocks:
created inode 0.
removed inode 0.
remove failed!
removed inode 1.
removed inode 3.
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 2:
    size: 0 bytes
    direct blocks:
25 disk block reads
8 disk block writes
EOF
}

cp data/image.5 $SCRATCH/image.5
trap "rm -fr $SCRATCH" INT QUIT TERM EXIT

echo -n "Testing remove in $SCRATCH/image.5 ... "
if diff -u <(test-0-input | ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(test-0-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "False"
    cat $SCRATCH/test.log
fi

# Test 1

test-1-input() {
    cat <<EOF
debug
mount
copyout 1 $SCRATCH/1.txt
create
copyin $SCRATCH/1.txt 0
create
copyin $SCRATCH/1.txt 2
debug
remove 0
debug
create
copyin $SCRATCH/1.txt 0
debug
EOF
}

test-1-output() {
    cat <<EOF
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 1:
    size: 965 bytes
    direct blocks: 2
disk mounted.
965 bytes copied
created inode 0.
965 bytes copied
created inode 2.
965 bytes copied
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 0:
    size: 965 bytes
    direct blocks: 3
Inode 1:
    size: 965 bytes
    direct blocks: 2
Inode 2:
    size: 965 bytes
    direct blocks: 4
removed inode 0.
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 1:
    size: 965 bytes
    direct blocks: 2
Inode 2:
    size: 965 bytes
    direct blocks: 4
created inode 0.
965 bytes copied
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 0:
    size: 965 bytes
    direct blocks: 3
Inode 1:
    size: 965 bytes
    direct blocks: 2
Inode 2:
    size: 965 bytes
    direct blocks: 4
27 disk block reads
10 disk block writes
EOF
}

cp data/image.5 $SCRATCH/image.5
echo -n "Testing remove in $SCRATCH/image.5 ... "
if diff -u <(test-1-input | ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(test-1-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "False"
    cat $SCRATCH/test.log
fi

# Test 2

test-2-input() {
    cat <<EOF
debug
mount
copyout 2 $SCRATCH/2.txt
remove 3
debug
create
copyin $SCRATCH/2.txt 0
debug
EOF
}

test-2-output() {
    cat <<EOF
SuperBlock:
    magic number is valid
    20 blocks
    2 inode blocks
    256 inodes
Inode 2:
    size: 27160 bytes
    direct blocks: 4 5 6 7 8
    indirect block: 9
    indirect data blocks: 13 14
Inode 3:
    size: 9546 bytes
    direct blocks: 10 11 12
disk mounted.
27160 bytes copied
removed inode 3.
SuperBlock:
    magic number is valid
    20 blocks
    2 inode blocks
    256 inodes
Inode 2:
    size: 27160 bytes
    direct blocks: 4 5 6 7 8
    indirect block: 9
    indirect data blocks: 13 14
created inode 0.
27160 bytes copied
SuperBlock:
    magic number is valid
    20 blocks
    2 inode blocks
    256 inodes
Inode 0:
    size: 27160 bytes
    direct blocks: 3 10 11 12 15
    indirect block: 16
    indirect data blocks: 17 18
Inode 2:
    size: 27160 bytes
    direct blocks: 4 5 6 7 8
    indirect block: 9
    indirect data blocks: 13 14
41 disk block reads
18 disk block writes
EOF
}

cp data/image.20 $SCRATCH/image.20
echo -n "Testing remove in $SCRATCH/image.20 ... "
if diff -u <(test-2-input | ./bin/sfssh $SCRATCH/image.20 20 2> /dev/null) <(test-2-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "False"
    cat $SCRATCH/test.log
fi
