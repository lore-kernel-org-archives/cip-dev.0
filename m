From: wagi@monom.org (Daniel Wagner)
Date: Mon, 12 Mar 2018 17:47:32 +0100
Subject: [cip-dev] [ANNOUNCE] 4.4.120-cip20-rt13
In-Reply-To: <CAEss1ELR0=AJEacFu0sF-9=wkuqmePSYKrV_KQdochKZVaxpyw@mail.gmail.com>
References: <20180309144337.7FEBD500C74@mail.monom.org>
	<CAEss1ELR0=AJEacFu0sF-9=wkuqmePSYKrV_KQdochKZVaxpyw@mail.gmail.com>
Message-ID: <766d9022-b640-fdb0-0599-c5e5f64db58c@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Zoran,

On 03/12/2018 01:25 PM, Zoran S wrote:
> Hello Daniel,
> 
> I did some tests using what I built here, on BeagleBone Black, namely
> two tests, to assure that kernel 4.4.120-cip20-rt13 works correctly.

Excellen!


> I did build this kernel using your own repo, adding it to my local
> Debian VM with Lava test framework, namely to the:
> http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/
> 

That is a good starting point. For -rt testing you should set following
options:

CONFIG_SMP=n
CONFIG_MODULES=n

CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCK_ALLOC=n
CONFIG_PROVE_LOCKING=n
CONFIG_LOCKDEP=n

CONFIG_CPU_FREQ=n
CONFIG_CPU_IDLE=n

CONFIG_NO_HZ=n
CONFIG_HZ_PERIODIC=y

CONFIG_HZ_250=y
CONFIG_HZ=250

CONFIG_SUSPEND=n
CONFIG_HIBERNATION=n
CONFIG_PM=n

CONFIG_FTRACE=n

CONFIG_PREEMPT_RT_FULL=y

> Both tests I have used are attached to this email:
> simple_test1.yaml
> mytest-bbb.yaml

Looks promising. So I got two major tests right now for -rt:

In one shell I run

	cyclictest -p 80 -n -m -S

Let it run for 30 minutes and see if the numbers are really bad or not.
Obviosly, you can start with smaller runtimes eg. 1 minute.

In other shell we need generate some load.  For the beginning we can use
something simple as hackbench

	while true; do hackbench ; done

Both tools are part or rt-tests package.

There is an example of the whole setup in ci-rt framework:

https://ci-rt.linutronix.de/RT-Test/kb_details.jsp?id=123&b_id=4543&bt_id=326

> 
> The ingredients used for the test are:
> |http://localhost:8010/initramfs/initramfs.cpio.gz
> ||http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/zImage
> ||http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/dtbs/am335x-boneblack.dtb
> ||http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/modules.tar.xz
> exists|
> 
> The first test is simplistic one (simple_test1.yaml), just to determine
> the few simple shell commands, where I also issued uname -a to be sure
> that I am testing the correct RT kernel:
> |uname -a| |
> Linux 192.168.15.159 4.4.120-cip20-rt13 #1 SMP Mon Mar 12 10:12:17 GMT
> 2018 armv7l GNU/Linux
> |
> 
> Result from this test are here: https://pastebin.com/eEz1NNWM||||
> 
> The second one (mytest-bbb.yaml) is one executing from Linaro site:
> |https://git.linaro.org/qa/test-definitions.git|
> 
> Result from this test are here: https://pastebin.com/5u51pnpb
> 
> I'll try the same tests on Renesas iW-RainboW-G20D-Qseven module.

Yes please. This looks really great.

Thanks,
Daniel
