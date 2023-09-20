#!/bin/bash

image-5-output() {
    cat <<EOF
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 1:
    size: 965 bytes
    direct blocks: 2
2 disk block reads
0 disk block writes
EOF
}

image-20-output() {
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
4 disk block reads
0 disk block writes
EOF
}

image-200-output() {
    cat <<EOF
SuperBlock:
    magic number is valid
    200 blocks
    20 inode blocks
    2560 inodes
Inode 1:
    size: 1523 bytes
    direct blocks: 152
Inode 2:
    size: 105421 bytes
    direct blocks: 49 50 51 52 53
    indirect block: 54
    indirect data blocks: 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75
Inode 9:
    size: 409305 bytes
    direct blocks: 22 23 24 25 26
    indirect block: 28
    indirect data blocks: 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 76 77 78 79 80 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151
23 disk block reads
0 disk block writes
EOF
}

test-debug() {
    DISK=$1
    BLOCKS=$2
    OUTPUT=$3

    echo -n "Testing debug on $DISK ... "
    if diff -u <(./bin/sfssh $DISK $BLOCKS <<<debug 2> /dev/null) <($OUTPUT) > test.log; then
    	echo "Success"
    else
    	echo "Failure"
    	cat test.log
    fi
    rm -f test.log
}

test-debug data/image.5   5   image-5-output
test-debug data/image.20  20  image-20-output
test-debug data/image.200 200 image-200-output
