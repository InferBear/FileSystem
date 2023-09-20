#!/bin/bash

SCRATCH=$(mktemp -d)
trap "rm -fr $SCRATCH" INT QUIT TERM EXIT

# Test: data/image.200

test-input() {
    cat <<EOF
debug
format
debug
mount
create
copyin README.md 0
create
copyin tests/test_cat.sh 1
create
stat 0
stat 1
stat 2
cat 0
cat 1
cat 2
debug
copyout 0 $SCRATCH/1.copy
copyout 1 $SCRATCH/2.copy
copyout 2 $SCRATCH/2.copy
remove 0
remove 1
remove 2
EOF

}

cp data/image.200 $SCRATCH/image.200
echo -n "Testing valgrind on $SCRATCH/image.200 ... "
errors=$(test-input | valgrind --leak-check=full ./bin/sfssh $SCRATCH/image.200 200 |& awk '/ERROR SUMMARY/ { print $4 }')
if [ $errors = 0 ]; then
    echo "Success"
else
    echo "Failure"
fi
