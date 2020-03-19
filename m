Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E2C4332B
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 11:05:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF3420740
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 11:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF3420740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2DF9A204FF;
	Thu, 19 Mar 2020 11:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pYSFVkrDvEG6; Thu, 19 Mar 2020 11:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38BAB204BC;
	Thu, 19 Mar 2020 11:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C758C07FF;
	Thu, 19 Mar 2020 11:05:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69979C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 11:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52FDF204FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 11:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UytHrU1sARiF for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 11:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id C7DF1204BC
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 11:05:28 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id AFFB61C031D; Thu, 19 Mar 2020 12:05:24 +0100 (CET)
Date: Thu, 19 Mar 2020 12:05:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Message-ID: <20200319110524.GA8475@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] realtime on de0-nano bisection
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8602656941333770981=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============8602656941333770981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm fighting with realtime on de0-nano, and I could use some
help... locating the bad commit. I don't seem to know enough about
test infrastructure to be effective. I pushed a tree I'm interested in
to:

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-cip

And I believe regression is somewhere in there. I just don't know
where.

List of commits is below. I believe 4.19.106-cip21 is okay while
4.19.106-cip21 is bad, and I have done some tests, but now it looks
like tests are unreliable (and even my basic assumptions may be worth
re-testing).

Can you help? I'll be away from console for a few hours now.

Thanks and best regards,
								Pavel



b4.19.106-rt-on-top

OK 122874576 0bf4ec5b1b8419e1c67a72182ee8d9b8d4a9337b 4.19.106-cip21
pick f1b053325784 ARM: at91: add TCB registers definitions
pick 48341c7208c6 clocksource/drivers: Add a new driver for the Atmel ARM T=
C blocks
pick 8ea74284f0da clocksource/drivers: timer-atmel-tcb: add clockevent devi=
ce on separate channel
pick 5429f0da23be clocksource/drivers: atmel-pit: make option silent
pick 6477898a723c ARM: at91: Implement clocksource selection
pick 52cdb2289480 ARM: configs: at91: use new TCB timer driver
pick 805b059109fa ARM: configs: at91: unselect PIT
pick d400fa638fcc irqchip/gic-v3-its: Move pending table allocation to init=
 time
pick 9310dd1ca83f kthread: convert worker lock to raw spinlock
pick 11024c8759f2 crypto: caam/qi - simplify CGR allocation, freeing
pick e08c2614be3c sched/fair: Robustify CFS-bandwidth timer locking
pick 1b7c0e7aeb78 arm: Convert arm boot_lock to raw
pick da304dd749c0 x86/ioapic: Don't let setaffinity unmask threaded EOI int=
errupt too early
pick efec2cbaa31b cgroup: use irqsave in cgroup_rstat_flush_locked()
pick 360801bc5876 fscache: initialize cookie hash table raw spinlocks
pick 9368b25dc6fa Drivers: hv: vmbus: include header for get_irq_regs()
pick 547927a23a72 percpu: include irqflags.h for raw_local_irq_save()
pick 2248f827f7d8 efi: Allow efi=3Druntime
pick a540fae71a61 x86/efi: drop task_lock() from efi_switch_mm()
pick 090e0c2d3c51 arm64: KVM: compute_layout before altenates are applied
pick a9e8d619b732 of: allocate / free phandle cache outside of the devtree_=
lock
pick 8bd06913a981 mm/kasan: make quarantine_lock a raw_spinlock_t
pick 47251e12064c EXP rcu: Revert expedited GP parallelization cleverness
pick 1848cf1f8210 kmemleak: Turn kmemleak_lock to raw spinlock on RT
pick 8571ad3b1f02 NFSv4: replace seqcount_t with a seqlock_t
pick a16f287d8bbb kernel: sched: Provide a pointer to the valid CPU mask
pick a10c47495dbd kernel/sched/core: add migrate_disable()
pick 73201d580f10 sched/migrate_disable: Add export_symbol_gpl for __migrat=
e_disabled
pick 6357e0136e18 arm: at91: do not disable/enable clocks in a row
pick d2df59c13604 clocksource: TCLIB: Allow higher clock rates for clock ev=
ents
pick 407b62737bc0 timekeeping: Split jiffies seqlock
pick 45e6903195c3 signal: Revert ptrace preempt magic
pick f64b620f24da net: sched: Use msleep() instead of yield()
pick 54eb2ef14895 dm rq: remove BUG_ON(!irqs_disabled) check
pick 2afd479fba8e usb: do no disable interrupts in giveback
pick ab55ba1c34b2 rt: Provide PREEMPT_RT_BASE config switch
pick c0619fc60437 cpumask: Disable CONFIG_CPUMASK_OFFSTACK for RT
pick f8682758dc6d jump-label: disable if stop_machine() is used
pick b56cc7361cd8 kconfig: Disable config options which are not RT compatib=
le
pick 1fda74e8a3e1 lockdep: disable self-test
pick f14436ae5581 mm: Allow only slub on RT
pick e4fb4a8d3396 locking: Disable spin on owner for RT
pick 47ad6acb6f1c rcu: Disable RCU_FAST_NO_HZ on RT
pick c825f6367871 rcu: make RCU_BOOST default on RT
pick 85f3409e8999 sched: Disable CONFIG_RT_GROUP_SCHED on RT
pick 804494b45253 net/core: disable NET_RX_BUSY_POLL
pick a53930db0419 arm*: disable NEON in kernel mode
pick b487b0f3edd3 powerpc: Use generic rwsem on RT
pick deac43aa4a58 powerpc/kvm: Disable in-kernel MPIC emulation for PREEMPT=
_RT_FULL
pick 9faa800cc8b8 powerpc: Disable highmem on RT
pick b51fe0939f41 mips: Disable highmem on RT
pick 30352c4f0ae4 x86: Use generic rwsem_spinlocks on -rt
pick a794e1ee2f1b leds: trigger: disable CPU trigger on -RT
pick f06b569ea39e cpufreq: drop K8's driver from beeing selected
pick 5fc3818dffbb md: disable bcache
pick a5f2f8f428a9 efi: Disable runtime services on RT
pick 446b178b5c4b printk: Add a printk kill switch
pick 290020fb828c printk: Add "force_early_printk" boot param to help with =
debugging
pick 41538af60819 preempt: Provide preempt_*_(no)rt variants
pick 3ae2dfc3a6e2 futex: workaround migrate_disable/enable in different con=
text
pick 8d271d63aa99 rt: Add local irq locks
pick 8f3ec1753f29 locallock: provide {get,put}_locked_ptr() variants
pick 83a11c32c1cf mm/scatterlist: Do not disable irqs on RT
pick 212b91e0dcb7 signal/x86: Delay calling signals in atomic
pick 91f375350d13 x86/signal: delay calling signals on 32bit
pick ef59f07235f3 buffer_head: Replace bh_uptodate_lock for -rt
pick 157d3af892d4 fs: jbd/jbd2: Make state lock and journal head lock rt sa=
fe
pick f83b8474e67e list_bl: Make list head locking RT safe
pick 0d7769b9e6d7 list_bl: fixup bogus lockdep warning
pick 23d976598fca genirq: Disable irqpoll on -rt
pick f482480c8949 genirq: Force interrupt thread on RT
pick cdd0a6dd6cf5 Split IRQ-off and zone->lock while freeing pages from PCP=
 list #1
pick 238c26eca475 Split IRQ-off and zone->lock while freeing pages from PCP=
 list #2
pick 9a2a5e8e197a mm/SLxB: change list_lock to raw_spinlock_t
pick cb8ddb1408a1 mm/SLUB: delay giving back empty slubs to IRQ enabled reg=
ions
pick 20228b9ad4cc mm: page_alloc: rt-friendly per-cpu pages
pick fe4307778243 mm/swap: Convert to percpu locked
pick 6f7bced91911 mm: perform lru_add_drain_all() remotely
pick 8cbb64035ad9 mm/vmstat: Protect per cpu variables with preempt disable=
 on RT
pick 639a673966b9 ARM: Initialize split page table locks for vector page
pick 0acf1cae0903 mm: Enable SLUB for RT
pick b50af682f2b7 slub: Enable irqs for __GFP_WAIT
pick 119281aade10 slub: Disable SLUB_CPU_PARTIAL
pick 8d00c57c199b mm/memcontrol: Don't call schedule_work_on in preemption =
disabled context
pick 1c3d8875431d mm/memcontrol: Replace local_irq_disable with local locks
pick 19d8df024e2f mm/zsmalloc: copy with get_cpu_var() and locking
pick 58ab0072e464 x86/mm/pat: disable preemption __split_large_page() after=
 spin_lock()
pick 68e40ee25e47 radix-tree: use local locks
pick 1a895e4d2468 timers: Prepare for full preemption
pick c03f3c65c426 x86: kvm Require const tsc for RT
pick 8c6fe368e93c pci/switchtec: Don't use completion's wait queue
pick 6ca0461b044c wait.h: include atomic.h
pick 7bf61e8d3fef work-simple: Simple work queue implemenation
pick 2799256f569f work-simple: drop a shit statement in SWORK_EVENT_PENDING
pick 102f6d1ac234 completion: Use simple wait queues
pick 47b3101f3d3c fs/aio: simple simple work
pick 7d2ab042333b genirq: Do not invoke the affinity callback via a workque=
ue on RT
pick 25088eb2a4eb time/hrtimer: avoid schedule_work() with interrupts disab=
led
pick 5b9f64173e94 hrtimer: consolidate hrtimer_init() + hrtimer_init_sleepe=
r() calls
pick 32ea9ed16efe hrtimers: Prepare full preemption
pick 9a1897cecdf6 hrtimer: by timers by default into the softirq context
pick b77213918ed5 sched/fair: Make the hrtimers non-hard again
pick e4d973f6534a hrtimer: Move schedule_work call to helper thread
pick 1f9f089947fc hrtimer: move state change before hrtimer_cancel in do_na=
nosleep()
pick f7e40a8d672b posix-timers: Thread posix-cpu-timers on -rt
pick 57c7cc8173dc sched: Move task_struct cleanup to RCU
pick e754db200003 sched: Limit the number of task migrations per batch
pick 1f870d384a18 sched: Move mmdrop to RCU on RT
pick daf050c81744 kernel/sched: move stack + kprobe clean up to __put_task_=
struct()
pick fa37473e6dba sched: Add saved_state for tasks blocked on sleeping locks
pick 2f85b7585307 sched: Do not account rcu_preempt_depth on RT in might_sl=
eep()
pick e3858ec6e217 sched: Use the proper LOCK_OFFSET for cond_resched()
pick ca1333aa370e sched: Disable TTWU_QUEUE on RT
pick 16f42ccd7684 sched/workqueue: Only wake up idle workers if not blocked=
 on sleeping spin lock
pick bf8f0c64f67d rt: Increase/decrease the nr of migratory tasks when enab=
ling/disabling migration
pick e06c269c2652 hotplug: Lightweight get online cpus
pick f2e100b9f722 trace: Add migrate-disabled counter to tracing output
pick c4429f1e6c31 lockdep: Make it RT aware
pick 4c99a296d07e tasklet: Prevent tasklets from going into infinite spin i=
n RT
pick 534dacca039e softirq: Check preemption after reenabling interrupts
pick 3a729860bc98 softirq: Disable softirq stacks for RT
pick 96a086038771 softirq: Split softirq locks
pick 618155302c43 net/core: use local_bh_disable() in netif_rx_ni()
pick 83a8d2a52ca3 genirq: Allow disabling of softirq processing in irq thre=
ad context
pick 3487fb436997 softirq: split timer softirqs out of ksoftirqd
pick f774fa3fcce1 softirq: Avoid "local_softirq_pending" messages if ksofti=
rqd is blocked
pick df000153612e softirq: Avoid "local_softirq_pending" messages if task i=
s in cpu_chill()
pick f6c58cb3103a rtmutex: trylock is okay on -RT
pick 9548e282eb13 fs/nfs: turn rmdir_sem into a semaphore
pick a8fd0847fc2f rtmutex: Handle the various new futex race conditions
pick 35bce82bb299 futex: Fix bug on when a requeued RT task times out
pick a955c20a684c futex: Ensure lock/unlock symetry versus pi_lock and hash=
 bucket lock
pick 26a04c6463c1 pid.h: include atomic.h
pick cdcef3c3c000 arm: include definition for cpumask_t
pick 3bca4d9be9ac locking: locktorture: Do NOT include rwlock.h directly
pick 42782ac504d4 rtmutex: Add rtmutex_lock_killable()
pick 2c8595a53cd4 rtmutex: Make lock_killable work
pick 23b3ca2280af spinlock: Split the lock types header
pick 5f60c6ae6dde rtmutex: Avoid include hell
pick 995ecbc4c0d3 rbtree: don't include the rcu header
pick 27e9eb247033 rtmutex: Provide rt_mutex_slowlock_locked()
pick a468d3437296 rtmutex: export lockdep-less version of rt_mutex's lock, =
trylock and unlock
pick 58790944fce8 rtmutex: add sleeping lock implementation
pick 052a52983b60 rtmutex: add mutex implementation based on rtmutex
pick b4235746586d rtmutex: add rwsem implementation based on rtmutex
pick 24d8016ec9e5 rtmutex: add rwlock implementation based on rtmutex
OK 122889823 pick e5c0eab8e437 rtmutex/rwlock: preserve state like a sleepi=
ng lock
pick 3bc0aceff337 rtmutex: wire up RT's locking
pick a7d5da8792ca rtmutex: add ww_mutex addon for mutex-rt
pick f9bde2392945 kconfig: Add PREEMPT_RT_FULL
pick 574150d18d52 locking/rt-mutex: fix deadlock in device mapper / block-IO
pick fabe7e1f9cc8 locking/rt-mutex: Flush block plug on __down_read()
pick 461cea5862c2 locking/rtmutex: re-init the wait_lock in rt_mutex_init_p=
roxy_locked()
pick 17dc818f1b09 ptrace: fix ptrace vs tasklist_lock race
pick e4eb4b5f10c3 rtmutex: annotate sleeping lock context
pick 833397adc966 sched/migrate_disable: fallback to preempt_disable() inst=
ead barrier()
pick a08b762ef304 locking: don't check for __LINUX_SPINLOCK_TYPES_H on -RT =
archs
pick 6cb3f91b9265 rcu: Frob softirq test
pick 050e3ab7293e rcu: Merge RCU-bh into RCU-preempt
pick d1f13f5715ff rcu: Make ksoftirqd do RCU quiescent states
pick 68e8f96963a0 rcu: Eliminate softirq processing from rcutree
pick c107e3408262 srcu: use cpu_online() instead custom check
pick 80dd78936722 srcu: replace local_irqsave() with a locallock
pick a1ea3f3b5d80 rcu: enable rcu_normal_after_boot by default for RT
pick 6e1f123fe270 tty/serial/omap: Make the locking RT aware
pick 53a1138616f2 tty/serial/pl011: Make the locking work on RT
pick f9f8eec35d32 tty: serial: pl011: explicitly initialize the flags varia=
ble
pick 846b95cf90a9 rt: Improve the serial console PASS_LIMIT
pick cd9897a02ce8 tty: serial: 8250: don't take the trylock during oops
pick 4d83234e6b83 locking/percpu-rwsem: Remove preempt_disable variants
pick 6c8fe3277d4b mm: Protect activate_mm() by preempt_[disable&enable]_rt()
pick 224aa887839e fs/dcache: bring back explicit INIT_HLIST_BL_HEAD init
pick a19ccfffd6fe fs/dcache: disable preemption on i_dir_seq's write side
pick 242dc74c7ba0 squashfs: make use of local lock in multi_cpu decompressor
pick efae64412664 thermal: Defer thermal wakups to threads
pick bd6193758b42 x86/fpu: Disable preemption around local_bh_disable()
pick 57754daf7ab5 fs/epoll: Do not disable preemption on RT
pick 5ba09ebcdb9d mm/vmalloc: Another preempt disable region which sucks
pick 2a14fc037798 block: mq: use cpu_light()
pick 44cb8f829fe8 block/mq: do not invoke preempt_disable()
pick 1a0cbc8049b7 block/mq: don't complete requests via IPI
pick 7e2a9e291159 md: raid5: Make raid5_percpu handling RT aware
pick 41f7be6a0bf6 rt: Introduce cpu_chill()
pick b4dc21395a7d hrtimer: Don't lose state in cpu_chill()
pick fd29abae38fa hrtimer: cpu_chill(): save task state in ->saved_state()
pick a7edd04c85ab block: blk-mq: move blk_queue_usage_counter_release() int=
o process context
pick 10c92f60395f block: Use cpu_chill() for retry loops
pick 68d5f72f6c39 fs: dcache: Use cpu_chill() in trylock loops
pick 7c5378410371 net: Use cpu_chill() instead of cpu_relax()
pick 96b93ac4f9ec fs/dcache: use swait_queue instead of waitqueue
pick 0d6428e557f2 workqueue: Use normal rcu
pick 46cdd4ce2bb4 workqueue: Use local irq lock instead of irq disable regi=
ons
pick e4771b3b1d75 workqueue: Prevent workqueue versus ata-piix livelock
pick 7f4d1437fd83 sched: Distangle worker accounting from rqlock
pick de5794c17deb debugobjects: Make RT aware
pick 5335646d22e8 seqlock: Prevent rt starvation
pick e533ff2a5246 sunrpc: Make svc_xprt_do_enqueue() use get_cpu_light()
pick 5e479879d1ce net: Use skbufhead with raw lock
pick b47b2fbf67cc net: move xmit_recursion to per-task variable on -RT
pick bd774d290977 net: provide a way to delegate processing a softirq to ks=
oftirqd
pick 2f116045c3f1 net: dev: always take qdisc's busylock in __dev_xmit_skb()
pick 29dbfaac29c5 net/Qdisc: use a seqlock instead seqcount
pick c7968ed6b615 net: add back the missing serialization in ip_send_unicas=
t_reply()
pick e5113ce66c06 net: add a lock around icmp_sk()
pick 2432ee4bae6c net: Have __napi_schedule_irqoff() disable interrupts on =
RT
pick fc9f4631a290 irqwork: push most work into softirq context
pick 04a1e1f2aa0d printk: Make rt aware
pick db508d28536f kernel/printk: Don't try to print from IRQ/NMI region
pick 502f80cc6396 printk: Drop the logbuf_lock more often
pick 1f904a831f47 ARM: enable irq in translation/section permission fault h=
andlers
pick d57873234f4e genirq: update irq_set_irqchip_state documentation
pick 1587d9b527d1 KVM: arm/arm64: downgrade preempt_disable()d region to mi=
grate_disable()
pick 9ad729bda0ad arm64: fpsimd: use preemp_disable in addition to local_bh=
_disable()
pick 9ea835e7e222 kgdb/serial: Short term workaround
pick 0def4cfed4bc sysfs: Add /sys/kernel/realtime entry
pick d6559d05ba28 mm, rt: kmap_atomic scheduling
pick 172af478fc0a x86/highmem: Add a "already used pte" check
pick aedd824e87cb arm/highmem: Flush tlb on unmap
pick 9e106bc3892f arm: Enable highmem for rt
pick 94434f02bd40 scsi/fcoe: Make RT aware.
pick 663928d94580 x86: crypto: Reduce preempt disabled regions
pick 9e1183c96782 crypto: Reduce preempt disabled regions, more algos
pick 6960b353f03e crypto: limit more FPU-enabled sections
pick 685152deb622 crypto: scompress - serialize RT percpu scratch buffer ac=
cess with a local lock
pick 6ac01984f2a0 crypto: cryptd - add a lock instead preempt_disable/local=
_bh_disable
pick 83c5815df005 panic: skip get_random_bytes for RT_FULL in init_oops_id
pick 04c6848abe95 x86: stackprotector: Avoid random pool on rt
pick d259cd9b1528 random: Make it work on rt
pick 2330ffd2ea17 cpu/hotplug: Implement CPU pinning
pick f51c291d7a8c sched: Allow pinned user tasks to be awakened to the CPU =
they pinned
pick 446d3b598f46 hotplug: duct-tape RT-rwlock usage for non-RT
pick 6fdea4f75772 net: Remove preemption disabling in netif_rx()
pick 33b361abdc67 net: Another local_irq_disable/kmalloc headache
pick 1ed4955c1659 net/core: protect users of napi_alloc_cache against reent=
rance
pick 31eac99e4c99 net: netfilter: Serialize xt_write_recseq sections on RT
pick e0e7b52f8feb net: Add a mutex around devnet_rename_seq
pick e21468d9dbb3 lockdep: selftest: Only do hardirq context test for raw s=
pinlock
pick c98e1e1915e3 lockdep: selftest: fix warnings due to missing PREEMPT_RT=
 conditionals
pick 1d80dd375f75 sched: Add support for lazy preemption
pick 526627fd4828 ftrace: Fix trace header alignment
pick 150dab4d290c x86: Support for lazy preemption
pick 04dc4533ed20 x86: lazy-preempt: properly check against preempt-mask
pick 4902852b7e48 x86: lazy-preempt: use proper return label on 32bit-x86
OK pick 948b7cfa39b0 arm: Add support for lazy preemption
pick 7628f6397275 powerpc: Add support for lazy preemption
pick 68e2b1f77c5d arch/arm64: Add lazy preempt support
pick 829e7d2af839 connector/cn_proc: Protect send_msg() with a local lock o=
n RT
pick bab609040081 drivers/block/zram: Replace bit spinlocks with rtmutex fo=
r -rt
pick 253dccd9c822 drivers/zram: Don't disable preemption in zcomp_stream_ge=
t/put()
pick 6e581927b8a9 drivers/zram: fix zcomp_stream_get() smp_processor_id() u=
se in preemptible code
pick a578207ba92a tpm_tis: fix stall after iowrite*()s
pick 5dbe4296d49c watchdog: prevent deferral of watchdogd wakeup on RT
pick 2076de67abf9 drm,radeon,i915: Use preempt_disable/enable_rt() where re=
commended
pick 0f3bcd6901e0 drm,i915: Use local_lock/unlock_irq() in intel_pipe_updat=
e_start/end()
pick 2089f853a8c3 drm/i915: disable tracing on -RT
pick c82fe0af5e58 drm/i915: skip DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE
pick 37925bf71573 cgroups: use simple wait in css_release()
pick c5eda0594d49 cpuset: Convert callback_lock to raw_spinlock_t
pick 756433e002d9 apparmor: use a locallock instead preempt_disable()
pick 73c433d86e25 workqueue: Prevent deadlock/stall on RT
pick 35bc2a5af2fe signals: Allow rt tasks to cache one sigqueue struct
pick 42c2f9cb1122 Add localversion for -RT release
pick 85773be1821e powerpc/pseries/iommu: Use a locallock instead local_irq_=
save()
pick 2667064a1f3f powerpc: reshuffle TIF bits
pick 55f7a7895171 tty/sysrq: Convert show_lock to raw_spinlock_t
pick b7cd1dad634c drm/i915: Don't disable interrupts independently of the l=
ock
pick 066e20ff7b54 sched/completion: Fix a lockup in wait_for_completion()
pick 54498c787596 kthread: add a global worker thread.
pick 80d5e2935a6c genirq: Do not invoke the affinity callback via a workque=
ue on RT
pick f9d3f116e098 genirq: Handle missing work_struct in irq_set_affinity_no=
tifier()
pick e2c1e143e74a arm: imx6: cpuidle: Use raw_spinlock_t
OK 122904930 / 122959477 pick 69aa73357e6a rcu: Don't allow to change rcu_n=
ormal_after_boot on RT
> bad? 122951549 bad? 126355890 real failure when entering usersace pick 84=
9ef8789077 pci/switchtec: fix stream_open.cocci warnings
pick ad8a5e8279c4 sched/core: Drop a preempt_disable_rt() statement
bad? 122942465 pick 966f066d96cb timers: Redo the notification of canceling=
 timers on -RT
pick 0393fd5a4f9a Revert "futex: Ensure lock/unlock symetry versus pi_lock =
and hash bucket lock"
pick 84eb0b64a27a Revert "futex: Fix bug on when a requeued RT task times o=
ut"
pick fcc893280f4e Revert "rtmutex: Handle the various new futex race condit=
ions"
pick 2eac93cf9d16 Revert "futex: workaround migrate_disable/enable in diffe=
rent context"
pick 9b8964629f4f futex: Make the futex_hash_bucket lock raw
pick cc1812bf198b futex: Delay deallocation of pi_state
bad? pick f5e115c43100 mm/zswap: Do not disable preemption in zswap_frontsw=
ap_store()
pick e0d0d09a08ad revert-aio
pick a0a40bfb4300 fs/aio: simple simple work
pick 0fae581d8c5e revert-thermal
pick c0d95b4a8a1b thermal: Defer thermal wakups to threads
pick 700fbb4afb6e revert-block
pick 4cda50ff12cf block: blk-mq: move blk_queue_usage_counter_release() int=
o process context
pick 9e982f55745b workqueue: rework
pick c0db53dc3bf4 i2c: exynos5: Remove IRQF_ONESHOT
pick 1f160d170203 i2c: hix5hd2: Remove IRQF_ONESHOT
BAD 122882826 eae5a7cab722 sched/deadline: Ensure inactive_timer runs in ha=
rdirq context
pick 6249683b77f6 thermal/x86_pkg_temp: make pkg_temp_lock a raw spinlock
pick 956a5c214a5b dma-buf: Use seqlock_t instread disabling preemption
pick 94f6fa62de56 KVM: arm/arm64: Let the timer expire in hardirq context o=
n RT
pick b1a74023533a x86: preempt: Check preemption level before looking at la=
zy-preempt
pick 1bdbd966d713 hrtimer: Use READ_ONCE to access timer->base in hrimer_gr=
ab_expiry_lock()
pick b87859791ff6 hrtimer: Don't grab the expiry lock for non-soft hrtimer
pick cc6c170874b9 hrtimer: Prevent using hrtimer_grab_expiry_lock() on migr=
ation_base
pick d5b21b1a259f hrtimer: Add a missing bracket and hide `migration_base' =
on !SMP
pick 6bc5d45d9c6f posix-timers: Unlock expiry lock in the early return
pick 05c2db84cb7a sched: migrate_dis/enable: Use sleeping_lock=E2=80=A6() t=
o annotate sleeping points
pick c282770121a7 sched: __set_cpus_allowed_ptr: Check cpus_mask, not cpus_=
ptr
pick e4f2a78d7ddb sched: Remove dead __migrate_disabled() check
pick 1a7d39dc51d2 sched: migrate disable: Protect cpus_ptr with lock
pick dda8037814c5 lib/smp_processor_id: Don't use cpumask_equal()
pick a7307f4e5926 futex: Make the futex_hash_bucket spinlock_t again and br=
ing back its old state
pick dad5e45d6919 locking/rtmutex: Clean ->pi_blocked_on in the error case
pick de2975927caf lib/ubsan: Don't seralize UBSAN report
pick 48b199bebe5c kmemleak: Change the lock of kmemleak_object to raw_spinl=
ock_t
pick 7a67c9eb660a sched: migrate_enable: Use select_fallback_rq()
pick 46f7b9689c65 sched: Lazy migrate_disable processing
pick 7bcbdecb866e sched: migrate_enable: Use stop_one_cpu_nowait()
pick 0c78796b3b3c Revert "ARM: Initialize split page table locks for vector=
 page"
pick 984f60beac6e locking: Make spinlock_t and rwlock_t a RCU section on RT
pick bdaac02765af sched/core: migrate_enable() must access takedown_cpu_tas=
k on !HOTPLUG_CPU
pick 041a0825cc80 lib/smp_processor_id: Adjust check_preemption_disabled()
pick 0aafa6ab4265 sched: migrate_enable: Busy loop until the migration requ=
est is completed
pick 08447476459e Linux 4.19.106-rt44 REBASE


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnNR9AAKCRAw5/Bqldv6
8rlHAJ9gOZB+0RKI09AEvyR4ArXc79dsQQCdF7n/jBe1ApXAhGXgsfhxS2XcoY0=
=kHaU
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============8602656941333770981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============8602656941333770981==--
