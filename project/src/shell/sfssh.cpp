// sfssh.cpp: Simple file system shell

#include "sfs/disk.h"
#include "sfs/fs.h"

#include <sstream>
#include <string>
#include <stdexcept>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Macros

#define streq(a, b) (strcmp((a), (b)) == 0)

// Command prototypes

void do_debug(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_format(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_mount(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_cat(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_copyout(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_create(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_remove(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_stat(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_copyin(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);
void do_help(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2);

bool copyout(FileSystem &fs, size_t inumber, const char *path);
bool copyin(FileSystem &fs, const char *path, size_t inumber);

// Main execution

int main(int argc, char *argv[]) {
    Disk	disk;
    FileSystem	fs;

    if (argc != 3) {
    	fprintf(stderr, "Usage: %s <diskfile> <nblocks>\n", argv[0]);
    	return EXIT_FAILURE;
    }

    try {
    	disk.open(argv[1], atoi(argv[2]));
    } catch (std::runtime_error &e) {
    	fprintf(stderr, "Unable to open disk %s: %s\n", argv[1], e.what());
    	return EXIT_FAILURE;
    }

    while (true) {
	char line[BUFSIZ], cmd[BUFSIZ], arg1[BUFSIZ], arg2[BUFSIZ];

    	fprintf(stderr, "sfs> ");
    	fflush(stderr);

    	if (fgets(line, BUFSIZ, stdin) == NULL) {
    	    break;
    	}

    	int args = sscanf(line, "%s %s %s", cmd, arg1, arg2);
    	if (args == 0) {
    	    continue;
	}

	if (streq(cmd, "debug")) {
	    do_debug(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "format")) {
	    do_format(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "mount")) {
	    do_mount(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "cat")) {
	    do_cat(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "copyout")) {
	    do_copyout(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "create")) {
	    do_create(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "remove")) {
	    do_remove(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "stat")) {
	    do_stat(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "copyin")) {
	    do_copyin(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "help")) {
	    do_help(disk, fs, args, arg1, arg2);
	} else if (streq(cmd, "exit") || streq(cmd, "quit")) {
	    break;
	} else {
	    printf("Unknown command: %s", line);
	    printf("Type 'help' for a list of commands.\n");
	}
    }

    return EXIT_SUCCESS;
}

// Command functions

void do_debug(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 1) {
    	printf("Usage: debug\n");
    	return;
    }

    fs.debug(&disk);
}

void do_format(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 1) {
    	printf("Usage: format\n");
    	return;
    }

    if (fs.format(&disk)) {
    	printf("disk formatted.\n");
    } else {
    	printf("format failed!\n");
    }
}

void do_mount(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 1) {
    	printf("Usage: mount\n");
    	return;
    }

    if (fs.mount(&disk)) {
    	printf("disk mounted.\n");
    } else {
    	printf("mount failed!\n");
    }
}

void do_cat(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 2) {
    	printf("Usage: cat <inode>\n");
    	return;
    }

    if (!copyout(fs, atoi(arg1), "/dev/stdout")) {
    	printf("cat failed!\n");
    }
}

void do_copyout(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 3) {
    	printf("Usage: copyout <inode> <file>\n");
    	return;
    }

    if (!copyout(fs, atoi(arg1), arg2)) {
    	printf("copyout failed!\n");
    }
}

void do_create(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 1) {
    	printf("Usage: create\n");
    	return;
    }

    ssize_t inumber = fs.create();
    if (inumber >= 0) {
    	printf("created inode %ld.\n", inumber);
    } else {
    	printf("create failed!\n");
    }
}

void do_remove(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 2) {
    	printf("Usage: remove <inode>\n");
    	return;
    }

    ssize_t inumber = atoi(arg1);
    if (fs.remove(inumber)) {
    	printf("removed inode %ld.\n", inumber);
    } else {
    	printf("remove failed!\n");
    }
}

void do_stat(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 2) {
    	printf("Usage: stat <inode>\n");
    	return;
    }

    ssize_t inumber = atoi(arg1);
    ssize_t bytes   = fs.stat(inumber);
    if (bytes >= 0) {
    	printf("inode %ld has size %ld bytes.\n", inumber, bytes);
    } else {
    	printf("stat failed!\n");
    }
}

void do_copyin(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    if (args != 3) {
    	printf("Usage: copyin <inode> <file>\n");
    	return;
    }

    if (!copyin(fs, arg1, atoi(arg2))) {
    	printf("copyin failed!\n");
    }
}

void do_help(Disk &disk, FileSystem &fs, int args, char *arg1, char *arg2) {
    printf("Commands are:\n");
    printf("    format\n");
    printf("    mount\n");
    printf("    debug\n");
    printf("    create\n");
    printf("    remove  <inode>\n");
    printf("    cat     <inode>\n");
    printf("    stat    <inode>\n");
    printf("    copyin  <file> <inode>\n");
    printf("    copyout <inode> <file>\n");
    printf("    help\n");
    printf("    quit\n");
    printf("    exit\n");
}

bool copyout(FileSystem &fs, size_t inumber, const char *path) {
    FILE *stream = fopen(path, "w");
    if (stream == nullptr) {
    	fprintf(stderr, "Unable to open %s: %s\n", path, strerror(errno));
    	return false;
    }

    char buffer[4*BUFSIZ] = {0};
    size_t offset = 0;
    while (true) {
    	ssize_t result = fs.read(inumber, buffer, sizeof(buffer), offset);
    	if (result <= 0) {
    	    break;
	}
	fwrite(buffer, 1, result, stream);
	offset += result;
    }

    printf("%lu bytes copied\n", offset);
    fclose(stream);
    return true;
}

bool copyin(FileSystem &fs, const char *path, size_t inumber) {
    FILE *stream = fopen(path, "r");
    if (stream == nullptr) {
    	fprintf(stderr, "Unable to open %s: %s\n", path, strerror(errno));
    	return false;
    }

    char buffer[4*BUFSIZ] = {0};
    size_t offset = 0;
    while (true) {
    	ssize_t result = fread(buffer, 1, sizeof(buffer), stream);
    	if (result <= 0) {
    	    break;
	}

	ssize_t actual = fs.write(inumber, buffer, result, offset);
	if (actual < 0) {
	    fprintf(stderr, "fs.write returned invalid result %ld\n", actual);
	    break;
	}
	offset += actual;
	if (actual != result) {
	    fprintf(stderr, "fs.write only wrote %ld bytes, not %ld bytes\n", actual, result);
	    break;
	}
    }

    printf("%lu bytes copied\n", offset);
    fclose(stream);
    return true;
}
