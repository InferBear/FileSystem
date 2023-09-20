// disk.h: Disk emulator

#pragma once

#include <stdlib.h>

class Disk {
private:
    int	    FileDescriptor; // File descriptor of disk image
    size_t  Blocks;	    // Number of blocks in disk image
    size_t  Reads;	    // Number of reads performed
    size_t  Writes;	    // Number of writes performed
    size_t  Mounts;	    // Number of mounts

    // Check parameters
    // @param	blocknum    Block to operate on
    // @param	data	    Buffer to operate on
    // Throws invalid_argument exception on error.
    void sanity_check(int blocknum, char *data);

public:
    // Number of bytes per block
    const static size_t BLOCK_SIZE = 4096;
    
    // Default constructor
    Disk() : FileDescriptor(0), Blocks(0), Reads(0), Writes(0), Mounts(0) {}
    
    // Destructor
    ~Disk();

    // Open disk image
    // @param	path	    Path to disk image
    // @param	nblocks	    Number of blocks in disk image
    // Throws runtime_error exception on error.
    void open(const char *path, size_t nblocks);

    // Return size of disk (in terms of blocks)
    size_t size() const { return Blocks; }

    // Return whether or not disk is mounted
    bool mounted() const { return Mounts > 0; }

    // Increment mounts
    void mount() { Mounts++; }

    // Decrement mounts
    void unmount() { if (Mounts > 0) Mounts--; }

    // Read block from disk
    // @param	blocknum    Block to read from
    // @param	data	    Buffer to read into
    void read(int blocknum, char *data);
    
    // Write block to disk
    // @param	blocknum    Block to write to
    // @param	data	    Buffer to write from
    void write(int blocknum, char *data);
};
