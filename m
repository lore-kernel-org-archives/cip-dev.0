From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Fri, 16 Mar 2018 15:57:02 +0100
Subject: [cip-dev] [ANNOUNCE] 4.4.120-cip20-rt13
In-Reply-To: <766d9022-b640-fdb0-0599-c5e5f64db58c@monom.org>
References: <20180309144337.7FEBD500C74@mail.monom.org>
	<CAEss1ELR0=AJEacFu0sF-9=wkuqmePSYKrV_KQdochKZVaxpyw@mail.gmail.com>
	<766d9022-b640-fdb0-0599-c5e5f64db58c@monom.org>
Message-ID: <CAEss1EL7HpNBB+ywuZjgXgjYSJYRG_6C8CSnYdKOHcMDpUSzOA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

I did tests as advised by you on BBB01. Unfortunately, I am (for now) not
able to do this on iwg20m, will be interesting to compare these two
platforms.

Sort of, to make more clear what the tests are, the following is short
clarification:

[1] while true; do hackbench ; done

user at host: ~ $ hackbench
Running in process mode with 10 groups using 40 file  descriptors
each (== 400 tasks)
Each sender will pass 100 messages of 100 bytes
Average time on my test for BBB01 is around 5.70

This default gives (on the long run) on BBB01 HW the average load
around 300! I could not believe my eyes, still BBB01 withstood such a
torturing! :-)

[2] cyclictest -p 80 -n -m -S
https://events.static.linuxfound.org/sites/events/files/slides/cyclictest.pdf

This .pdf explains all in details.
_______

Now, I made one unsuccessful attempt to create the correct .config,
where the following happened:

CONFIG_SUSPEND=y
CONFIG_HIBERNATION=y
CONFIG_PM=y
CONFIG_PREEMPT_RT_FULL=n

Here are results from such a configuration, after approximately 60
minutes of running:

root at beaglebone:~# cyclictest -p 80 -n -m -S
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 279.21 300.75 315.83 387/480 30402

T: 0 ( 8880) P:80 I:1000 C:3453637 Min:     15 Act:   49 Avg:   51 *Max:  *
*1386*

Then I again have created the whole .config file again, deleting all the
previous build, and this time this was a correct .config.

Please, find it attached to this email (the full .config version) as CONFIG
(since some other people might want to try such BBB01 RT tests).

And here are results from the run, which lasted around ~50 minutes (~3
million cycles):
root at beaglebone:~# uname -a
Linux beaglebone 4.4.120-cip20-rt13-dirty #1 PREEMPT RT Fri Mar 16 13:41:18
GMT 2018 armv7l GNU/Linux

root at beaglebone:~# cyclictest -p 80 -n -m -S
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 203.66 71.89 25.88 159/504 8144
policy: fifo: loadavg: 282.71 297.38 290.00 196/504 10767
T: 0 ( 7343) P:80 I:1000 C:   9151 Min:     19 Act:   44 Avg:   42
Max:      68
*T: 0 ( 7343) P:80 I:1000 C:3129069 Min:      8 Act:   31 Avg:   42
Max:      81*

*Excellent job done on 4.4.120-cip20-rt13! Hats Down!*

Thank you,
Zoran
_______

On Mon, Mar 12, 2018 at 5:47 PM, Daniel Wagner <wagi@monom.org> wrote:

> Hi Zoran,
>
> On 03/12/2018 01:25 PM, Zoran S wrote:
> > Hello Daniel,
> >
> > I did some tests using what I built here, on BeagleBone Black, namely
> > two tests, to assure that kernel 4.4.120-cip20-rt13 works correctly.
>
> Excellen!
>
>
> > I did build this kernel using your own repo, adding it to my local
> > Debian VM with Lava test framework, namely to the:
> > http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-
> cip20-rt13/arm/omap2plus_defconfig/
> >
>
> That is a good starting point. For -rt testing you should set following
> options:
>
> CONFIG_SMP=n
> CONFIG_MODULES=n
>
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCK_ALLOC=n
> CONFIG_PROVE_LOCKING=n
> CONFIG_LOCKDEP=n
>
> CONFIG_CPU_FREQ=n
> CONFIG_CPU_IDLE=n
>
> CONFIG_NO_HZ=n
> CONFIG_HZ_PERIODIC=y
>
> CONFIG_HZ_250=y
> CONFIG_HZ=250
>
> CONFIG_SUSPEND=n
> CONFIG_HIBERNATION=n
> CONFIG_PM=n
>
> CONFIG_FTRACE=n
>
> CONFIG_PREEMPT_RT_FULL=y
>
> > Both tests I have used are attached to this email:
> > simple_test1.yaml
> > mytest-bbb.yaml
>
> Looks promising. So I got two major tests right now for -rt:
>
> In one shell I run
>
>         cyclictest -p 80 -n -m -S
>
> Let it run for 30 minutes and see if the numbers are really bad or not.
> Obviosly, you can start with smaller runtimes eg. 1 minute.
>
> In other shell we need generate some load.  For the beginning we can use
> something simple as hackbench
>
>         while true; do hackbench ; done
>
> Both tools are part or rt-tests package.
>
> There is an example of the whole setup in ci-rt framework:
>
> https://ci-rt.linutronix.de/RT-Test/kb_details.jsp?id=123&
> b_id=4543&bt_id=326
>
> >
> > The ingredients used for the test are:
> > |http://localhost:8010/initramfs/initramfs.cpio.gz
> > ||http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-
> cip20-rt13/arm/omap2plus_defconfig/zImage
> > ||http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-
> cip20-rt13/arm/omap2plus_defconfig/dtbs/am335x-boneblack.dtb
> > ||http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-
> cip20-rt13/arm/omap2plus_defconfig/modules.tar.xz
> > exists|
> >
> > The first test is simplistic one (simple_test1.yaml), just to determine
> > the few simple shell commands, where I also issued uname -a to be sure
> > that I am testing the correct RT kernel:
> > |uname -a| |
> > Linux 192.168.15.159 4.4.120-cip20-rt13 #1 SMP Mon Mar 12 10:12:17 GMT
> > 2018 armv7l GNU/Linux
> > |
> >
> > Result from this test are here: https://pastebin.com/eEz1NNWM||||
> >
> > The second one (mytest-bbb.yaml) is one executing from Linaro site:
> > |https://git.linaro.org/qa/test-definitions.git|
> >
> > Result from this test are here: https://pastebin.com/5u51pnpb
> >
> > I'll try the same tests on Renesas iW-RainboW-G20D-Qseven module.
>
> Yes please. This looks really great.
>
> Thanks,
> Daniel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180316/b24fa3d5/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: CONFIG
Type: application/octet-stream
Size: 101177 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180316/b24fa3d5/attachment-0001.obj>
