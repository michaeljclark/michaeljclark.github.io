## Linux syscalls

The following tables list the syscalls supported by the user-mode
simulators `rv-sim` and `rv-jit`. Note: the user-mode simulator supports
simulation of Linux syscalls on macOS.

_**Linux Emulated Syscalls**_

System Call     | Number | Notes
:---            | --:    |
ioctl           | 29     | supports TIOCGWINSZ for musl isatty
openat          | 56
close           | 57
lseek           | 62
read            | 63
write           | 64
readv           | 65
writev          | 66
pread           | 67
pwrite          | 68
fstatat         | 79
fstat           | 80
exit            | 93
exit_group      | 94
set_tid_address | 96     | returns tid 1
clock_gettime   | 113
uname           | 160
getrusage       | 165
gettimeofday    | 169
brk             | 214
munmap          | 215    | protected regions and flag conversion
mmap            | 222    | protected regions and flag conversion
mprotect        | 226
madvise         | 233    | nop
prlimit64       | 261
open            | 1024
unlink          | 1026
stat            | 1038
chown           | 1039
