<a href="https://rv8.io/"><img style="float: right;" src="/images/rv8.svg"></a>

## rv8 benchmarks

Some preliminary runtime results comparing qemu, rv-jit and native x86:

![benchmark runtimes -O3]({{ site.url }}/plots/runtime-O3.svg)
![benchmark runtimes -Os]({{ site.url }}/plots/runtime-Os.svg)

Some preliminary micro-op/instruction count results comparing RISC-V and x86:

![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-64.svg)
![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-64.svg)
![operation counts -O3 64-bit]({{ site.url }}/plots/operations-O3-32.svg)
![operation counts -Os 64-bit]({{ site.url }}/plots/operations-Os-32.svg)

Some preliminary gcc filesize results comparing aarch64, riscv32, riscv64, x86-32 and x86-64:

![benchmark filesizes -O3]({{ site.url }}/plots/filesize-O3.svg)
![benchmark filesizes -Os]({{ site.url }}/plots/filesize-Os.svg)
