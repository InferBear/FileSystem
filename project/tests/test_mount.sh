#!/bin/bash

#!/bin/bash

mount-input() {
    cat <<EOF
mount
EOF
}

mount-output() {
    cat <<EOF
disk mounted.
2 disk block reads
0 disk block writes
EOF
}

mount-mount-input() {
    cat <<EOF
mount
mount
EOF
}

mount-mount-output() {
    cat <<EOF
disk mounted.
mount failed!
2 disk block reads
0 disk block writes
EOF
}

mount-format-input() {
    cat <<EOF
mount
format
EOF
}

mount-format-output() {
    cat <<EOF
disk mounted.
format failed!
2 disk block reads
0 disk block writes
EOF
}

test-mount () {
    TEST=$1

    echo -n "Testing $TEST on data/image.5 ... "
    if diff -u <($TEST-input| ./bin/sfssh data/image.5 5 2> /dev/null) <($TEST-output) > test.log; then
    	echo "Success"
    else
    	echo "Failure"
	cat test.log
    fi
    rm -f test.log
}

test-mount mount
test-mount mount-mount
test-mount mount-format

SCRATCH=$(mktemp -d)
trap "rm -fr $SCRATCH" INT QUIT TERM EXIT

bad-mount-input() {
    cat <<EOF
mount
EOF
}

bad-mount-output() {
    cat <<EOF
mount failed!
1 disk block reads
0 disk block writes
EOF
}

echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x10 0x34 0xf1 0xf0) >  $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x05 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x01 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x80 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n "Testing bad-mount on $SCRATCH/image.5 ... "
if diff -u <(bad-mount-input| ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(bad-mount-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "Failure"
    cat $SCRATCH/test.log
fi

echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x10 0x34 0xf1 0xf0) >  $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x05 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x01 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x80 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n "Testing bad-mount on $SCRATCH/image.5 ... "
if diff -u <(bad-mount-input| ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(bad-mount-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "Failure"
    cat $SCRATCH/test.log
fi

echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x10 0x34 0xf0 0xf0) >  $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x00 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x01 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x80 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n "Testing bad-mount on $SCRATCH/image.5 ... "
if diff -u <(bad-mount-input| ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(bad-mount-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "Failure"
    cat $SCRATCH/test.log
fi

echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x10 0x34 0xf0 0xf0) >  $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x05 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x02 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x80 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n "Testing bad-mount on $SCRATCH/image.5 ... "
if diff -u <(bad-mount-input| ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(bad-mount-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "Failure"
    cat $SCRATCH/test.log
fi

echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x10 0x34 0xf0 0xf0) >  $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x05 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x01 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n -e $(printf '\\x%x\\x%x\\x%x\\x%x' 0x70 0x00 0x00 0x00) >> $SCRATCH/image.5
echo -n "Testing bad-mount on $SCRATCH/image.5 ... "
if diff -u <(bad-mount-input| ./bin/sfssh $SCRATCH/image.5 5 2> /dev/null) <(bad-mount-output) > $SCRATCH/test.log; then
    echo "Success"
else
    echo "Failure"
    cat $SCRATCH/test.log
fi
