// disk.cpp: disk emulator

#include "sfs/disk.h"

#include <stdexcept>

#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

void Disk::open(const char *path, size_t nblocks) {
    FileDescriptor = ::open(path, O_RDWR|O_CREAT, 0600);
    if (FileDescriptor < 0) {
    	char what[BUFSIZ];
    	snprintf(what, BUFSIZ, "Unable to open %s: %s", path, strerror(errno));
    	throw std::runtime_error(what);
    }

    if (ftruncate(FileDescriptor, nblocks*BLOCK_SIZE) < 0) {
    	char what[BUFSIZ];
    	snprintf(what, BUFSIZ, "Unable to open %s: %s", path, strerror(errno));
    	throw std::runtime_error(what);
    }

    Blocks = nblocks;
    Reads  = 0;
    Writes = 0;
}

Disk::~Disk() {
    if (FileDescriptor > 0) {
    	printf("%lu disk block reads\n", Reads);
    	printf("%lu disk block writes\n", Writes);
    	close(FileDescriptor);
    	FileDescriptor = 0;
    }
}

void Disk::sanity_check(int blocknum, char *data) {
    char what[BUFSIZ];

    if (blocknum < 0) {
    	snprintf(what, BUFSIZ, "blocknum (%d) is negative!", blocknum);
    	throw std::invalid_argument(what);
    }

    if (blocknum >= (int)Blocks) {
    	snprintf(what, BUFSIZ, "blocknum (%d) is too big!", blocknum);
    	throw std::invalid_argument(what);
    }

    if (data == NULL) {
    	snprintf(what, BUFSIZ, "null data pointer!");
    	throw std::invalid_argument(what);
    }
}

void Disk::read(int blocknum, char *data) {
    sanity_check(blocknum, data);

    if (lseek(FileDescriptor, blocknum*BLOCK_SIZE, SEEK_SET) < 0) {
    	char what[BUFSIZ];
    	snprintf(what, BUFSIZ, "Unable to lseek %d: %s", blocknum, strerror(errno));
    	throw std::runtime_error(what);
    }

    if (::read(FileDescriptor, data, BLOCK_SIZE) != BLOCK_SIZE) {
    	char what[BUFSIZ];
    	snprintf(what, BUFSIZ, "Unable to read %d: %s", blocknum, strerror(errno));
    	throw std::runtime_error(what);
    }

    Reads++;
}

void Disk::write(int blocknum, char *data) {
    sanity_check(blocknum, data);

    if (lseek(FileDescriptor, blocknum*BLOCK_SIZE, SEEK_SET) < 0) {
    	char what[BUFSIZ];
    	snprintf(what, BUFSIZ, "Unable to lseek %d: %s", blocknum, strerror(errno));
    	throw std::runtime_error(what);
    }

    if (::write(FileDescriptor, data, BLOCK_SIZE) != BLOCK_SIZE) {
    	char what[BUFSIZ];
    	snprintf(what, BUFSIZ, "Unable to write %d: %s", blocknum, strerror(errno));
    	throw std::runtime_error(what);
    }

    Writes++;
}
