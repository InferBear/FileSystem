#!/bin/bash

test-input() {
    echo debug
    echo mount
    for i in $(seq 128); do
    	echo create
    done
    echo debug
}

test-output() {
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
created inode 4.
created inode 5.
created inode 6.
created inode 7.
created inode 8.
created inode 9.
created inode 10.
created inode 11.
created inode 12.
created inode 13.
created inode 14.
created inode 15.
created inode 16.
created inode 17.
created inode 18.
created inode 19.
created inode 20.
created inode 21.
created inode 22.
created inode 23.
created inode 24.
created inode 25.
created inode 26.
created inode 27.
created inode 28.
created inode 29.
created inode 30.
created inode 31.
created inode 32.
created inode 33.
created inode 34.
created inode 35.
created inode 36.
created inode 37.
created inode 38.
created inode 39.
created inode 40.
created inode 41.
created inode 42.
created inode 43.
created inode 44.
created inode 45.
created inode 46.
created inode 47.
created inode 48.
created inode 49.
created inode 50.
created inode 51.
created inode 52.
created inode 53.
created inode 54.
created inode 55.
created inode 56.
created inode 57.
created inode 58.
created inode 59.
created inode 60.
created inode 61.
created inode 62.
created inode 63.
created inode 64.
created inode 65.
created inode 66.
created inode 67.
created inode 68.
created inode 69.
created inode 70.
created inode 71.
created inode 72.
created inode 73.
created inode 74.
created inode 75.
created inode 76.
created inode 77.
created inode 78.
created inode 79.
created inode 80.
created inode 81.
created inode 82.
created inode 83.
created inode 84.
created inode 85.
created inode 86.
created inode 87.
created inode 88.
created inode 89.
created inode 90.
created inode 91.
created inode 92.
created inode 93.
created inode 94.
created inode 95.
created inode 96.
created inode 97.
created inode 98.
created inode 99.
created inode 100.
created inode 101.
created inode 102.
created inode 103.
created inode 104.
created inode 105.
created inode 106.
created inode 107.
created inode 108.
created inode 109.
created inode 110.
created inode 111.
created inode 112.
created inode 113.
created inode 114.
created inode 115.
created inode 116.
created inode 117.
created inode 118.
created inode 119.
created inode 120.
created inode 121.
created inode 122.
created inode 123.
created inode 124.
created inode 125.
created inode 126.
created inode 127.
create failed!
SuperBlock:
    magic number is valid
    5 blocks
    1 inode blocks
    128 inodes
Inode 0:
    size: 0 bytes
    direct blocks:
Inode 1:
    size: 965 bytes
    direct blocks: 2
Inode 2:
    size: 0 bytes
    direct blocks:
Inode 3:
    size: 0 bytes
    direct blocks:
Inode 4:
    size: 0 bytes
    direct blocks:
Inode 5:
    size: 0 bytes
    direct blocks:
Inode 6:
    size: 0 bytes
    direct blocks:
Inode 7:
    size: 0 bytes
    direct blocks:
Inode 8:
    size: 0 bytes
    direct blocks:
Inode 9:
    size: 0 bytes
    direct blocks:
Inode 10:
    size: 0 bytes
    direct blocks:
Inode 11:
    size: 0 bytes
    direct blocks:
Inode 12:
    size: 0 bytes
    direct blocks:
Inode 13:
    size: 0 bytes
    direct blocks:
Inode 14:
    size: 0 bytes
    direct blocks:
Inode 15:
    size: 0 bytes
    direct blocks:
Inode 16:
    size: 0 bytes
    direct blocks:
Inode 17:
    size: 0 bytes
    direct blocks:
Inode 18:
    size: 0 bytes
    direct blocks:
Inode 19:
    size: 0 bytes
    direct blocks:
Inode 20:
    size: 0 bytes
    direct blocks:
Inode 21:
    size: 0 bytes
    direct blocks:
Inode 22:
    size: 0 bytes
    direct blocks:
Inode 23:
    size: 0 bytes
    direct blocks:
Inode 24:
    size: 0 bytes
    direct blocks:
Inode 25:
    size: 0 bytes
    direct blocks:
Inode 26:
    size: 0 bytes
    direct blocks:
Inode 27:
    size: 0 bytes
    direct blocks:
Inode 28:
    size: 0 bytes
    direct blocks:
Inode 29:
    size: 0 bytes
    direct blocks:
Inode 30:
    size: 0 bytes
    direct blocks:
Inode 31:
    size: 0 bytes
    direct blocks:
Inode 32:
    size: 0 bytes
    direct blocks:
Inode 33:
    size: 0 bytes
    direct blocks:
Inode 34:
    size: 0 bytes
    direct blocks:
Inode 35:
    size: 0 bytes
    direct blocks:
Inode 36:
    size: 0 bytes
    direct blocks:
Inode 37:
    size: 0 bytes
    direct blocks:
Inode 38:
    size: 0 bytes
    direct blocks:
Inode 39:
    size: 0 bytes
    direct blocks:
Inode 40:
    size: 0 bytes
    direct blocks:
Inode 41:
    size: 0 bytes
    direct blocks:
Inode 42:
    size: 0 bytes
    direct blocks:
Inode 43:
    size: 0 bytes
    direct blocks:
Inode 44:
    size: 0 bytes
    direct blocks:
Inode 45:
    size: 0 bytes
    direct blocks:
Inode 46:
    size: 0 bytes
    direct blocks:
Inode 47:
    size: 0 bytes
    direct blocks:
Inode 48:
    size: 0 bytes
    direct blocks:
Inode 49:
    size: 0 bytes
    direct blocks:
Inode 50:
    size: 0 bytes
    direct blocks:
Inode 51:
    size: 0 bytes
    direct blocks:
Inode 52:
    size: 0 bytes
    direct blocks:
Inode 53:
    size: 0 bytes
    direct blocks:
Inode 54:
    size: 0 bytes
    direct blocks:
Inode 55:
    size: 0 bytes
    direct blocks:
Inode 56:
    size: 0 bytes
    direct blocks:
Inode 57:
    size: 0 bytes
    direct blocks:
Inode 58:
    size: 0 bytes
    direct blocks:
Inode 59:
    size: 0 bytes
    direct blocks:
Inode 60:
    size: 0 bytes
    direct blocks:
Inode 61:
    size: 0 bytes
    direct blocks:
Inode 62:
    size: 0 bytes
    direct blocks:
Inode 63:
    size: 0 bytes
    direct blocks:
Inode 64:
    size: 0 bytes
    direct blocks:
Inode 65:
    size: 0 bytes
    direct blocks:
Inode 66:
    size: 0 bytes
    direct blocks:
Inode 67:
    size: 0 bytes
    direct blocks:
Inode 68:
    size: 0 bytes
    direct blocks:
Inode 69:
    size: 0 bytes
    direct blocks:
Inode 70:
    size: 0 bytes
    direct blocks:
Inode 71:
    size: 0 bytes
    direct blocks:
Inode 72:
    size: 0 bytes
    direct blocks:
Inode 73:
    size: 0 bytes
    direct blocks:
Inode 74:
    size: 0 bytes
    direct blocks:
Inode 75:
    size: 0 bytes
    direct blocks:
Inode 76:
    size: 0 bytes
    direct blocks:
Inode 77:
    size: 0 bytes
    direct blocks:
Inode 78:
    size: 0 bytes
    direct blocks:
Inode 79:
    size: 0 bytes
    direct blocks:
Inode 80:
    size: 0 bytes
    direct blocks:
Inode 81:
    size: 0 bytes
    direct blocks:
Inode 82:
    size: 0 bytes
    direct blocks:
Inode 83:
    size: 0 bytes
    direct blocks:
Inode 84:
    size: 0 bytes
    direct blocks:
Inode 85:
    size: 0 bytes
    direct blocks:
Inode 86:
    size: 0 bytes
    direct blocks:
Inode 87:
    size: 0 bytes
    direct blocks:
Inode 88:
    size: 0 bytes
    direct blocks:
Inode 89:
    size: 0 bytes
    direct blocks:
Inode 90:
    size: 0 bytes
    direct blocks:
Inode 91:
    size: 0 bytes
    direct blocks:
Inode 92:
    size: 0 bytes
    direct blocks:
Inode 93:
    size: 0 bytes
    direct blocks:
Inode 94:
    size: 0 bytes
    direct blocks:
Inode 95:
    size: 0 bytes
    direct blocks:
Inode 96:
    size: 0 bytes
    direct blocks:
Inode 97:
    size: 0 bytes
    direct blocks:
Inode 98:
    size: 0 bytes
    direct blocks:
Inode 99:
    size: 0 bytes
    direct blocks:
Inode 100:
    size: 0 bytes
    direct blocks:
Inode 101:
    size: 0 bytes
    direct blocks:
Inode 102:
    size: 0 bytes
    direct blocks:
Inode 103:
    size: 0 bytes
    direct blocks:
Inode 104:
    size: 0 bytes
    direct blocks:
Inode 105:
    size: 0 bytes
    direct blocks:
Inode 106:
    size: 0 bytes
    direct blocks:
Inode 107:
    size: 0 bytes
    direct blocks:
Inode 108:
    size: 0 bytes
    direct blocks:
Inode 109:
    size: 0 bytes
    direct blocks:
Inode 110:
    size: 0 bytes
    direct blocks:
Inode 111:
    size: 0 bytes
    direct blocks:
Inode 112:
    size: 0 bytes
    direct blocks:
Inode 113:
    size: 0 bytes
    direct blocks:
Inode 114:
    size: 0 bytes
    direct blocks:
Inode 115:
    size: 0 bytes
    direct blocks:
Inode 116:
    size: 0 bytes
    direct blocks:
Inode 117:
    size: 0 bytes
    direct blocks:
Inode 118:
    size: 0 bytes
    direct blocks:
Inode 119:
    size: 0 bytes
    direct blocks:
Inode 120:
    size: 0 bytes
    direct blocks:
Inode 121:
    size: 0 bytes
    direct blocks:
Inode 122:
    size: 0 bytes
    direct blocks:
Inode 123:
    size: 0 bytes
    direct blocks:
Inode 124:
    size: 0 bytes
    direct blocks:
Inode 125:
    size: 0 bytes
    direct blocks:
Inode 126:
    size: 0 bytes
    direct blocks:
Inode 127:
    size: 0 bytes
    direct blocks:
261 disk block reads
127 disk block writes
EOF
}

cp data/image.5 data/image.5.create
trap "rm -f data/image.5.create" INT QUIT TERM EXIT

echo -n "Testing create in data/image.5.create ... "
if diff -q <(test-input | ./bin/sfssh data/image.5.create 5 2> /dev/null) <(test-output); then
    echo "Success"
else
    echo "False"
fi
