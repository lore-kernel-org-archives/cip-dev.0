From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 4 May 2018 11:22:53 +0000
Subject: [cip-dev] iWave RZ/G1M hrtimers
In-Reply-To: <45738fc6-fe53-8309-77ab-be6204fdc68c@monom.org>
References: <288bed25-0560-69a2-7239-d25387f9ab64@monom.org>
	<45738fc6-fe53-8309-77ab-be6204fdc68c@monom.org>
Message-ID: <OSBPR01MB2103BDA152FACACF7085F50EB8860@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

We just  backported CMT timers to CIP kernel. We will be sending this patches soon.

With this , I get below output.  Is it the output are you looking for?

root at skrzg1m:~# cat /proc/timer_list
Timer List Version: v0.8
HRTIMER_MAX_CLOCK_BASES: 4
now at 16058914800 nsecs

cpu: 0
 clock 0:
  .base:       dfbc7c00
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <dfbc7e00>, tick_sched_timer, S:01
 # expires at 16110000000-16110000000 nsecs [in 51085200 to 51085200 nsecs]
 #1: <df44baa8>, hrtimer_wakeup, S:01
 # expires at 20097691700-20102691698 nsecs [in 4038776900 to 4043776898 nsecs]
 #2: <de99bb48>, hrtimer_wakeup, S:01
 # expires at 111784518100-111881501098 nsecs [in 95725603300 to 95822586298 nsecs]
 #3: <c0707df0>, sched_clock_poll, S:01
 # expires at 4398046511100-4398046511100 nsecs [in 4381987596300 to 4381987596300 nsecs]
 clock 1:
  .base:       dfbc7c20
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1525421024384776700 nsecs
active timers:
 clock 2:
  .base:       dfbc7c40
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       dfbc7c60
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     1525421024384776700 nsecs
active timers:
  .expires_next   : 16110000000 nsecs
  .hres_active    : 1
  .nr_events      : 601
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0
  .nohz_mode      : 2
  .last_tick      : 16060000000 nsecs
  .tick_stopped   : 1
  .idle_jiffies   : 4294938901
  .idle_calls     : 9210
  .idle_sleeps    : 950
  .idle_entrytime : 16057975400 nsecs
  .idle_waketime  : 16057922600 nsecs
  .idle_exittime  : 16057949300 nsecs
  .idle_sleeptime : 14284047200 nsecs
  .iowait_sleeptime: 86741100 nsecs
  .last_jiffies   : 4294938901
  .next_timer     : 16110000000
  .idle_expires   : 16110000000 nsecs
jiffies: 4294938901

cpu: 1
 clock 0:
  .base:       dfbd1c00
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <dfbd1e00>, tick_sched_timer, S:01
 # expires at 16060000000-16060000000 nsecs [in 1085200 to 1085200 nsecs]
 #1: <de977b48>, hrtimer_wakeup, S:01
 # expires at 39563256900-39593256897 nsecs [in 23504342100 to 23534342097 nsecs]
 clock 1:
  .base:       dfbd1c20
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1525421024384776700 nsecs
active timers:
 clock 2:
  .base:       dfbd1c40
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       dfbd1c60
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     1525421024384776700 nsecs
active timers:
  .expires_next   : 16060000000 nsecs
  .hres_active    : 1
  .nr_events      : 1354
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0
  .nohz_mode      : 2
  .last_tick      : 16060000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294938901
  .idle_calls     : 4469
  .idle_sleeps    : 945
  .idle_entrytime : 16057969200 nsecs
  .idle_waketime  : 16010001400 nsecs
  .idle_exittime  : 16052140500 nsecs
  .idle_sleeptime : 12943485800 nsecs
  .iowait_sleeptime: 329857100 nsecs
  .last_jiffies   : 4294938901
  .next_timer     : 16170000000
  .idle_expires   : 16170000000 nsecs
jiffies: 4294938901

Tick Device: mode:     1
Broadcast device
Clock Event Device: ffca0000.timer
 max_delta_ns:   1082682478542939
 min_delta_ns:   7814532
 mult:           17038
 shift:          32
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: sh_cmt_clock_event_next
 shutdown: sh_cmt_clock_event_shutdown
 periodic: sh_cmt_clock_event_set_periodic
 oneshot:  sh_cmt_clock_event_set_oneshot
 event_handler:  tick_handle_oneshot_broadcast
 retries:        0

tick_broadcast_mask: 0
tick_broadcast_oneshot_mask: 0

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: arch_sys_timer
 max_delta_ns:   214748364501
 min_delta_ns:   1500
 mult:           42949673
 shift:          32
 mode:           3
 next_event:     16070000000 nsecs
 set_next_event: arch_timer_set_next_event_virt
 shutdown: arch_timer_shutdown_virt
 event_handler:  hrtimer_interrupt
 retries:        0

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: arch_sys_timer
 max_delta_ns:   214748364501
 min_delta_ns:   1500
 mult:           42949673
 shift:          32
 mode:           3
 next_event:     16070000000 nsecs
 set_next_event: arch_timer_set_next_event_virt
 shutdown: arch_timer_shutdown_virt
 event_handler:  hrtimer_interrupt
 retries:        790

root at skrzg1m:~#

regards,
Biju

> -----Original Message-----
> From: Daniel Wagner [mailto:wagi at monom.org]
> Sent: 04 May 2018 11:26
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>; cip-dev at lists.cip-
> project.org
> Subject: Re: [cip-dev] iWave RZ/G1M hrtimers
>
> On 05/04/2018 12:16 PM, Daniel Wagner wrote:
> > Hi Biju,
> >
> > Not sure if I ping the right person about this problem.
> >
> > I am doing some realtime testing on the iWave RZ/G1M board and noticed
> > quite high latency values for cyclictest (around 3ms).
> >
> > As it turns out there is no hrtimer clock source available. Just the
> > arch cp8 clock source. The timer subsystem then decides to set the
> > resolution of the clocksource to 4000000 nsecs which explains the
> > rather bad value for cyclictest.
> >
> >
> > clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
> > 0x24e6a1710, max_idle_ns: 440795202120 ns
> > sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every
> > 4398046511100ns Switching to timer-based delay loop, resolution 100ns
> >
> > # cat current_clocksource
> > arch_sys_counter
> >
> > # cat available_clocksource
> > arch_sys_counter jiffies
> >
> > # cat /proc/timer_list
> > Timer List Version: v0.8
> > HRTIMER_MAX_CLOCK_BASES: 4
> > now at 1705568146462 nsecs
> >
> > cpu: 0
> >    clock 0:
> >     .base:       dfbcbe40
> >     .index:      0
> >     .resolution: 4000000 nsecs
> >     .get_time:   ktime_get
> >     .offset:     0 nsecs
> >
> >
> > The question is do I miss some magic CONFIG option or is the support
> > not yet in v4.4-cip ?
>
> Forgot to mention. I am using the shmobile_defconfig configuration with
> some mods on top of it:
>
> # systemd stuff
> CONFIG_CGROUPS=y
> CONFIG_CGROUP_DEBUG=n
> CONFIG_CGROUP_FREEZER=n
> CONFIG_INOTIFY_USER=y
> CONFIG_FHANDLE=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_TMPFS_XATTR=y
>
> # -rt tunnings
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
> CONFIG_HIGH_RES_TIMERS=y
>
> CONFIG_SUSPEND=n
> CONFIG_HIBERNATION=n
> CONFIG_PM=n
>
> CONFIG_PREEMPT_RT_FULL=y
>
> # root nfs
> CONFIG_NFS_FS=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
>
> # some debugging stuff
> CONFIG_FTRACE=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_SCHED_TRACER=y



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
