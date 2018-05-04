From: wagi@monom.org (Daniel Wagner)
Date: Fri, 04 May 2018 16:32:08 +0200
Subject: [cip-dev] [ANNOUNCE] 4.4.126-cip22-rt16
Message-ID: <20180504143641.5E0FB500C12@mail.monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello CIP RT Folks!

I'm pleased to announce the 4.4.126-cip22-rt16 stable release.

With this release the v4.4-cip-rt tree is again in sync with the
v4.4-rt tree. The two patch queues (v4.4-rt and v4.4-rt-cip) are now
equal.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git

  branch: linux-4.4.y-cip-rt
  Head SHA1: aef273080eec787845e26313d232bc8e1e070b6a

Enjoy!
   Daniel

Changes from v4.4.126-cip22-rt15:
---
Alex Shi (1):
      cpu_pm: replace raw_notifier to atomic_notifier

Daniel Wagner (1):
      Linux 4.4.126-cip22-rt16

Mike Galbraith (1):
      kernel/hrtimer/hotplug: don't wake ktimersoftd while holding the hrtimer base lock

Mikulas Patocka (1):
      locking/rt-mutex: fix deadlock in device mapper / block-IO

Peter Zijlstra (1):
      sched: Remove TASK_ALL

Sebastian Andrzej Siewior (16):
      timer/hrtimer: check properly for a running timer
      random: avoid preempt_disable()ed section
      sched/migrate disable: handle updated task-mask mg-dis section
      kernel/locking: use an exclusive wait_q for sleepers
      fs: convert two more BH_Uptodate_Lock related bitspinlocks
      md/raid5: do not disable interrupts
      Revert "fs: jbd2: pull your plug when waiting for space"
      kernel/hrtimer: migrate deferred timer on CPU down
      kernel/hrtimer: don't wakeup a process while holding the hrtimer base lock
      Bluetooth: avoid recursive locking in hci_send_to_channel()
      rt/locking: allow recursive local_trylock()
      net: use trylock in icmp_sk
      locking: add types.h
      mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
      arm*: disable NEON in kernel mode
      crypto: limit more FPU-enabled sections

Steven Rostedt (VMware) (1):
      Revert "memcontrol: Prevent scheduling while atomic in cgroup code"

Thomas Gleixner (3):
      rtmutex: Make lock_killable work
      sched: Prevent task state corruption by spurious lock wakeup
      timer: Invoke timer_start_debug() where it makes sense

---
 arch/arm/Kconfig                           |  2 +-
 arch/arm64/crypto/Kconfig                  | 14 +++---
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 20 ++++++++
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 19 +++++++
 arch/x86/crypto/cast6_avx_glue.c           | 24 +++++++--
 arch/x86/crypto/chacha20_glue.c            |  8 +--
 arch/x86/crypto/serpent_avx2_glue.c        | 19 +++++++
 arch/x86/crypto/serpent_avx_glue.c         | 23 +++++++--
 arch/x86/crypto/serpent_sse2_glue.c        | 23 +++++++--
 arch/x86/crypto/twofish_avx_glue.c         | 27 +++++++++-
 arch/x86/include/asm/fpu/api.h             |  1 +
 arch/x86/kernel/fpu/core.c                 | 12 +++++
 drivers/char/random.c                      | 10 ++--
 drivers/md/raid5.c                         |  4 +-
 fs/ext4/page-io.c                          |  6 +--
 fs/jbd2/checkpoint.c                       |  2 -
 include/linux/hrtimer.h                    |  8 ++-
 include/linux/locallock.h                  |  9 ++++
 include/linux/sched.h                      | 19 +++++--
 include/linux/spinlock_types_raw.h         |  2 +
 kernel/cpu_pm.c                            | 43 +++-------------
 kernel/fork.c                              |  1 +
 kernel/locking/rtmutex.c                   | 46 ++++++++++-------
 kernel/sched/core.c                        | 81 ++++++++++++++++++++++++++----
 kernel/time/hrtimer.c                      | 35 +++++++++----
 kernel/time/timer.c                        |  4 +-
 localversion-cip-rt                        |  2 +-
 mm/memcontrol.c                            |  7 +--
 mm/slub.c                                  |  1 +
 net/bluetooth/hci_sock.c                   | 17 ++++---
 net/ipv4/icmp.c                            |  6 ++-
 31 files changed, 363 insertions(+), 132 deletions(-)
