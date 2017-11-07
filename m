From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 07 Nov 2017 17:42:25 +0000
Subject: [cip-dev] Detecting Performance Regressions in the Linux Kernel -
	Jan Kara
In-Reply-To: <1510076438.2465.31.camel@codethink.co.uk>
References: <1510076438.2465.31.camel@codethink.co.uk>
Message-ID: <1510076545.2465.33.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

## Detecting Performance Regressions in the Linux Kernel - Jan Kara

[Description](https://osseu17.sched.com/event/BxIY/)

SUSE runs performance tests on a "grid" of different machines (10 x86,
1 ARM).??The x86 machines have a wide range of CPUs, memory size,
storage performance.??There are two back-to-back connected pairs for
network tests.

Other instances of the same models are available for debugging.

### Software used

"Marvin" is their framework for deploying, scheduling tests, bisecting.

"MMTests" is a framework for benchmarks - parses results and generates
comparisons - <https://github.com/gormanm/mmtests>.

CPU benchmarks: hackbench. libmicro, kernel page alloc benchmark (with
special module), PFT, SPECcpu2016, and others,

IO benchmarks: Iozone, Bonnie, Postmark, Reaim, Dbench4.??These are
run for all supported filesystems (ext3, ext4, xfs, btrfs) and
different RAID and non-RAID configurations.

Network benchmarks: sockperf, netperf, netpipe, siege.??These are run
over loopback and 10 gigabit Ethernet using Unix domain sockets (where
applicable), TCP, and UDP.??siege doesn't scale well so will be
replaced.

Complex benchmarks: kernbench, SPECjvm, Pgebcnh, sqlite insertion,
Postgres & MariaDB OLTP, ...

### How to detect performance changes?

Comparing a single benchmark result from each version is no good -
there is often significant variance in results.??It is necessary to
take multiple measurements, calculate average and s.d.

Caches and other features for increasing performance involve
prediction, which creates strong statistical dependencies.
Some statistical tests assume samples come from a normal
distribution, but performance results often don't.

It is sometimes possible to use Welch's T-test for significance of a
difference, but it is often necessary to plot a graph to understand
how the performance distribution is different - it can be due to
small numbers of outliers.

Some benchmarks take multiple (but not enough) results and average
them internally.??Ideally a benchmark framework will get all the
results and do its own statistical analysis.??For this reason, MMTests
uses modified versions of some benchmarks.

### Reducing variance in benchmarks

Filesystems: create from scratch each time

Scheduling: bind tasks to specific NUMA nodes; disable background
services; reboot before starting

It's generally not possible to control memory layout (which affects
cache performance) or interrupt timing.

### Benchmarks are buggy

* Setup can take most of the time
* Averages are not always calculated correctly
* Output is sometimes not flushed at exit, causing it to be truncated

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
