From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:32:25 +0000
Subject: [cip-dev] [PATCH 4.4-cip 00/23] Undefined Behaviour Sanititizer
	support
Message-ID: <1481243545.1860.156.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is a backport of changes in 4.5 to add support for GCC's Undefined
Behaviour Sanitizer (UBSAN), and fixes for undefined behaviour that it
has found (that are not already in 4.4.30).

UBSAN detects (at run time) many operations that will result in
undefined behaviour, i.e. unpredictable results.  These include overflow
of signed integer calculations, bitwise shifts by too many places, and
some array bounds errors.   (KASAN detects other kinds of address
errors, but is currently only supported on arm64 and x86_64.)  See
<http://developerblog.redhat.com/2014/10/16/gcc-undefined-behavior-sanitizer-ubsan/> for more information.

UBSAN can be enabled globally on x86 (CONFIG_UBSAN_SANITIZE_ALL), but
must be enabled selectively on arm (add 'UBSAN_SANITIZE := y' to the
Makefile in each directory you want to apply it to).  I assume there are
a few critical regions of code that must to be avoided.
It has a significant performance cost, so it is unlikely to be suitable
for use in production builds.

For this and other backports, I'm looking for feedback like:
- Did I miss a follow-up fix or an earlier dependency?
- Does this cause a regression (other than as explained above)?
- Are you likely to use it?
- Are there related features you want in 4.4?

Ben.

Adam Borowski (2):
  perf/x86/amd: Set the size of event map array to PERF_COUNT_HW_MAX
  btrfs: fix int32 overflow in shrink_delalloc().

Andrey Ryabinin (3):
  UBSAN: run-time undefined behavior sanity checker
  mm/page-writeback: fix dirty_ratelimit calculation
  ubsan: fix tree-wide -Wmaybe-uninitialized false positives

Bartlomiej Zolnierkiewicz (1):
  blk-mq: fix undefined behaviour in order_to_size()

Chris Bainbridge (1):
  x86/microcode/intel: Change checksum variables to u32

David Decotigny (1):
  mlx4: remove unused fields

Eric Biggers (1):
  PM / sleep: declare __tracedata symbols as char[] rather than char

Eric Dumazet (1):
  net: get rid of an signed integer overflow in ip_idents_reserve()

Nicolai Stange (2):
  mm/filemap: generic_file_read_iter(): check for zero reads
    unconditionally
  drm/radeon: don't include RADEON_HPD_NONE in HPD IRQ enable bitsets

Nicolas Iooss (1):
  UBSAN: fix typo in format string

Oleg Nesterov (1):
  signal: move the "sig < SIGRTMIN" check into siginmask(sig)

Peter Zijlstra (1):
  perf/core: Fix Undefined behaviour in rb_alloc()

Seung-Woo Kim (2):
  mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
  pwm: samsung: Fix to use lowest div for large enough modulation bits

Sven Eckelmann (1):
  batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq

Vegard Nossum (2):
  rhashtable: fix shift by 64 when shrinking
  time: Avoid undefined behaviour in ktime_add_safe()

Xie XiuQi (2):
  drm: fix signed integer overflow
  xfs: fix signed integer overflow

Yang Shi (1):
  ubsan: cosmetic fix to Kconfig text

 Documentation/ubsan.txt                   |  84 ++++++
 Makefile                                  |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/boot/Makefile                    |   1 +
 arch/x86/boot/compressed/Makefile         |   1 +
 arch/x86/entry/vdso/Makefile              |   1 +
 arch/x86/kernel/cpu/microcode/intel_lib.c |   8 +-
 arch/x86/kernel/cpu/perf_event_amd.c      |   2 +-
 arch/x86/realmode/rm/Makefile             |   1 +
 block/blk-mq.c                            |   2 +-
 drivers/base/power/trace.c                |   4 +-
 drivers/firmware/efi/libstub/Makefile     |   1 +
 drivers/gpu/drm/drm_hashtab.c             |   2 +-
 drivers/gpu/drm/radeon/evergreen.c        |   6 +-
 drivers/gpu/drm/radeon/r100.c             |   6 +-
 drivers/gpu/drm/radeon/r600.c             |   6 +-
 drivers/gpu/drm/radeon/rs600.c            |   6 +-
 drivers/mmc/host/dw_mmc.c                 |  14 +-
 drivers/mmc/host/dw_mmc.h                 |   4 -
 drivers/net/ethernet/mellanox/mlx4/fw.c   |   4 -
 drivers/net/ethernet/mellanox/mlx4/fw.h   |   2 -
 drivers/pwm/pwm-samsung.c                 |  15 +-
 fs/btrfs/extent-tree.c                    |   2 +-
 fs/xfs/xfs_buf_item.c                     |   4 +-
 include/linux/ktime.h                     |   7 +
 include/linux/sched.h                     |   3 +
 include/linux/signal.h                    |  16 +-
 kernel/events/ring_buffer.c               |   6 +-
 kernel/time/hrtimer.c                     |   2 +-
 lib/Kconfig.debug                         |   1 +
 lib/Kconfig.ubsan                         |  36 +++
 lib/Makefile                              |   3 +
 lib/rhashtable.c                          |   6 +-
 lib/ubsan.c                               | 456 ++++++++++++++++++++++++++++++
 lib/ubsan.h                               |  84 ++++++
 mm/filemap.c                              |   7 +-
 mm/kasan/Makefile                         |   1 +
 mm/page-writeback.c                       |  11 +-
 net/batman-adv/bat_iv_ogm.c               |   5 +-
 net/ipv4/route.c                          |  10 +-
 scripts/Makefile.lib                      |   6 +
 scripts/Makefile.ubsan                    |  21 ++
 42 files changed, 792 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/ubsan.txt
 create mode 100644 lib/Kconfig.ubsan
 create mode 100644 lib/ubsan.c
 create mode 100644 lib/ubsan.h
 create mode 100644 scripts/Makefile.ubsan

-- 
2.10.2


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
