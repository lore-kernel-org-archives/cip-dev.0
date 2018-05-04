From: wagi@monom.org (Daniel Wagner)
Date: Fri, 4 May 2018 12:25:47 +0200
Subject: [cip-dev] iWave RZ/G1M hrtimers
In-Reply-To: <288bed25-0560-69a2-7239-d25387f9ab64@monom.org>
References: <288bed25-0560-69a2-7239-d25387f9ab64@monom.org>
Message-ID: <45738fc6-fe53-8309-77ab-be6204fdc68c@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05/04/2018 12:16 PM, Daniel Wagner wrote:
> Hi Biju,
> 
> Not sure if I ping the right person about this problem.
> 
> I am doing some realtime testing on the iWave RZ/G1M board and noticed
> quite high latency values for cyclictest (around 3ms).
> 
> As it turns out there is no hrtimer clock source available. Just the
> arch cp8 clock source. The timer subsystem then decides to set the
> resolution of the clocksource to 4000000 nsecs which explains the rather
> bad value for cyclictest.
> 
> 
> clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
> 0x24e6a1710, max_idle_ns: 440795202120 ns
> sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
> Switching to timer-based delay loop, resolution 100ns
> 
> # cat current_clocksource
> arch_sys_counter
> 
> # cat available_clocksource
> arch_sys_counter jiffies
> 
> # cat /proc/timer_list
> Timer List Version: v0.8
> HRTIMER_MAX_CLOCK_BASES: 4
> now at 1705568146462 nsecs
> 
> cpu: 0
>    clock 0:
>     .base:       dfbcbe40
>     .index:      0
>     .resolution: 4000000 nsecs
>     .get_time:   ktime_get
>     .offset:     0 nsecs
> 
> 
> The question is do I miss some magic CONFIG option or is the support not
> yet in v4.4-cip ?

Forgot to mention. I am using the shmobile_defconfig configuration with 
some mods on top of it:

# systemd stuff
CONFIG_CGROUPS=y
CONFIG_CGROUP_DEBUG=n
CONFIG_CGROUP_FREEZER=n
CONFIG_INOTIFY_USER=y
CONFIG_FHANDLE=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_AUTOFS4_FS=y
CONFIG_TMPFS_XATTR=y

# -rt tunnings
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

CONFIG_HIGH_RES_TIMERS=y

CONFIG_SUSPEND=n
CONFIG_HIBERNATION=n
CONFIG_PM=n

CONFIG_PREEMPT_RT_FULL=y

# root nfs
CONFIG_NFS_FS=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y

# some debugging stuff
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_SCHED_TRACER=y
