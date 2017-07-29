<a href="https://rv8.io/"><img style="float: right;" src="/images/rv8.svg"></a>

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
fstat           | 80
exit            | 93
exit_group      | 94
set_tid_address | 96     | returns tid 1
clock_gettime   | 113
uname           | 160
gettimeofday    | 169
brk             | 214
munmap          | 215    | protected regions and flag conversion
mmap            | 222    | protected regions and flag conversion
open            | 1024
unlink          | 1026
stat            | 1038
chown           | 1039

[![rv8]({{ site.url }}/images/rv8.svg)](https://rv8.io/)
