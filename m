From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Dec 2016 23:57:14 +0000
Subject: [cip-dev] [PATCH 4.4-cip 1/6] mm: mmap: add new /proc tunable for
 mmap_base ASLR
In-Reply-To: <1481241380.1860.120.camel@codethink.co.uk>
References: <1481241380.1860.120.camel@codethink.co.uk>
Message-ID: <1481241434.1860.121.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Daniel Cashman <dcashman@google.com>

commit d07e22597d1d355829b7b18ac19afa912cf758d1 upstream.

Address Space Layout Randomization (ASLR) provides a barrier to
exploitation of user-space processes in the presence of security
vulnerabilities by making it more difficult to find desired code/data
which could help an attack.  This is done by adding a random offset to
the location of regions in the process address space, with a greater
range of potential offset values corresponding to better protection/a
larger search-space for brute force, but also to greater potential for
fragmentation.

The offset added to the mmap_base address, which provides the basis for
the majority of the mappings for a process, is set once on process exec
in arch_pick_mmap_layout() and is done via hard-coded per-arch values,
which reflect, hopefully, the best compromise for all systems.  The
trade-off between increased entropy in the offset value generation and
the corresponding increased variability in address space fragmentation
is not absolute, however, and some platforms may tolerate higher amounts
of entropy.  This patch introduces both new Kconfig values and a sysctl
interface which may be used to change the amount of entropy used for
offset generation on a system.

The direct motivation for this change was in response to the
libstagefright vulnerabilities that affected Android, specifically to
information provided by Google's project zero at:

  http://googleprojectzero.blogspot.com/2015/09/stagefrightened.html

The attack presented therein, by Google's project zero, specifically
targeted the limited randomness used to generate the offset added to the
mmap_base address in order to craft a brute-force-based attack.
Concretely, the attack was against the mediaserver process, which was
limited to respawning every 5 seconds, on an arm device.  The hard-coded
8 bits used resulted in an average expected success rate of defeating
the mmap ASLR after just over 10 minutes (128 tries at 5 seconds a
piece).  With this patch, and an accompanying increase in the entropy
value to 16 bits, the same attack would take an average expected time of
over 45 hours (32768 tries), which makes it both less feasible and more
likely to be noticed.

The introduced Kconfig and sysctl options are limited by per-arch
minimum and maximum values, the minimum of which was chosen to match the
current hard-coded value and the maximum of which was chosen so as to
give the greatest flexibility without generating an invalid mmap_base
address, generally a 3-4 bits less than the number of bits in the
user-space accessible virtual address space.

When decided whether or not to change the default value, a system
developer should consider that mmap_base address could be placed
anywhere up to 2^(value) bits away from the non-randomized location,
which would introduce variable-sized areas above and below the mmap_base
address such that the maximum vm_area_struct size may be reduced,
preventing very large allocations.

This patch (of 4):

ASLR only uses as few as 8 bits to generate the random offset for the
mmap base address on 32 bit architectures.  This value was chosen to
prevent a poorly chosen value from dividing the address space in such a
way as to prevent large allocations.  This may not be an issue on all
platforms.  Allow the specification of a minimum number of bits so that
platforms desiring greater ASLR protection may determine where to place
the trade-off.

Signed-off-by: Daniel Cashman <dcashman@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Nick Kralevich <nnk@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Hector Marco-Gisbert <hecmargi@upv.es>
Cc: Borislav Petkov <bp@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 Documentation/sysctl/vm.txt | 29 +++++++++++++++++++
 arch/Kconfig                | 68 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h          | 11 ++++++++
 kernel/sysctl.c             | 22 +++++++++++++++
 mm/mmap.c                   | 12 ++++++++
 5 files changed, 142 insertions(+)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index f72370b440b1..ee763f3d3b52 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -42,6 +42,8 @@ Currently, these files are in /proc/sys/vm:
 - min_slab_ratio
 - min_unmapped_ratio
 - mmap_min_addr
+- mmap_rnd_bits
+- mmap_rnd_compat_bits
 - nr_hugepages
 - nr_overcommit_hugepages
 - nr_trim_pages         (only if CONFIG_MMU=n)
@@ -485,6 +487,33 @@ against future potential kernel bugs.
 
 ==============================================================
 
+mmap_rnd_bits:
+
+This value can be used to select the number of bits to use to
+determine the random offset to the base address of vma regions
+resulting from mmap allocations on architectures which support
+tuning address space randomization.  This value will be bounded
+by the architecture's minimum and maximum supported values.
+
+This value can be changed after boot using the
+/proc/sys/vm/mmap_rnd_bits tunable
+
+==============================================================
+
+mmap_rnd_compat_bits:
+
+This value can be used to select the number of bits to use to
+determine the random offset to the base address of vma regions
+resulting from mmap allocations for applications run in
+compatibility mode on architectures which support tuning address
+space randomization.  This value will be bounded by the
+architecture's minimum and maximum supported values.
+
+This value can be changed after boot using the
+/proc/sys/vm/mmap_rnd_compat_bits tunable
+
+==============================================================
+
 nr_hugepages
 
 Change the minimum size of the hugepage pool.
diff --git a/arch/Kconfig b/arch/Kconfig
index 4e949e58b192..ba1b626bca00 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -511,6 +511,74 @@ config ARCH_HAS_ELF_RANDOMIZE
 	  - arch_mmap_rnd()
 	  - arch_randomize_brk()
 
+config HAVE_ARCH_MMAP_RND_BITS
+	bool
+	help
+	  An arch should select this symbol if it supports setting a variable
+	  number of bits for use in establishing the base address for mmap
+	  allocations, has MMU enabled and provides values for both:
+	  - ARCH_MMAP_RND_BITS_MIN
+	  - ARCH_MMAP_RND_BITS_MAX
+
+config ARCH_MMAP_RND_BITS_MIN
+	int
+
+config ARCH_MMAP_RND_BITS_MAX
+	int
+
+config ARCH_MMAP_RND_BITS_DEFAULT
+	int
+
+config ARCH_MMAP_RND_BITS
+	int "Number of bits to use for ASLR of mmap base address" if EXPERT
+	range ARCH_MMAP_RND_BITS_MIN ARCH_MMAP_RND_BITS_MAX
+	default ARCH_MMAP_RND_BITS_DEFAULT if ARCH_MMAP_RND_BITS_DEFAULT
+	default ARCH_MMAP_RND_BITS_MIN
+	depends on HAVE_ARCH_MMAP_RND_BITS
+	help
+	  This value can be used to select the number of bits to use to
+	  determine the random offset to the base address of vma regions
+	  resulting from mmap allocations. This value will be bounded
+	  by the architecture's minimum and maximum supported values.
+
+	  This value can be changed after boot using the
+	  /proc/sys/vm/mmap_rnd_bits tunable
+
+config HAVE_ARCH_MMAP_RND_COMPAT_BITS
+	bool
+	help
+	  An arch should select this symbol if it supports running applications
+	  in compatibility mode, supports setting a variable number of bits for
+	  use in establishing the base address for mmap allocations, has MMU
+	  enabled and provides values for both:
+	  - ARCH_MMAP_RND_COMPAT_BITS_MIN
+	  - ARCH_MMAP_RND_COMPAT_BITS_MAX
+
+config ARCH_MMAP_RND_COMPAT_BITS_MIN
+	int
+
+config ARCH_MMAP_RND_COMPAT_BITS_MAX
+	int
+
+config ARCH_MMAP_RND_COMPAT_BITS_DEFAULT
+	int
+
+config ARCH_MMAP_RND_COMPAT_BITS
+	int "Number of bits to use for ASLR of mmap base address for compatible applications" if EXPERT
+	range ARCH_MMAP_RND_COMPAT_BITS_MIN ARCH_MMAP_RND_COMPAT_BITS_MAX
+	default ARCH_MMAP_RND_COMPAT_BITS_DEFAULT if ARCH_MMAP_RND_COMPAT_BITS_DEFAULT
+	default ARCH_MMAP_RND_COMPAT_BITS_MIN
+	depends on HAVE_ARCH_MMAP_RND_COMPAT_BITS
+	help
+	  This value can be used to select the number of bits to use to
+	  determine the random offset to the base address of vma regions
+	  resulting from mmap allocations for compatible applications This
+	  value will be bounded by the architecture's minimum and maximum
+	  supported values.
+
+	  This value can be changed after boot using the
+	  /proc/sys/vm/mmap_rnd_compat_bits tunable
+
 config HAVE_COPY_THREAD_TLS
 	bool
 	help
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0ffa01c90d9..ee18791531e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -51,6 +51,17 @@ extern int sysctl_legacy_va_layout;
 #define sysctl_legacy_va_layout 0
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
+extern const int mmap_rnd_bits_min;
+extern const int mmap_rnd_bits_max;
+extern int mmap_rnd_bits __read_mostly;
+#endif
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
+extern const int mmap_rnd_compat_bits_min;
+extern const int mmap_rnd_compat_bits_max;
+extern int mmap_rnd_compat_bits __read_mostly;
+#endif
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 999e025bf68e..9bc9f56b8b3d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1568,6 +1568,28 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
+	{
+		.procname	= "mmap_rnd_bits",
+		.data		= &mmap_rnd_bits,
+		.maxlen		= sizeof(mmap_rnd_bits),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= (void *)&mmap_rnd_bits_min,
+		.extra2		= (void *)&mmap_rnd_bits_max,
+	},
+#endif
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
+	{
+		.procname	= "mmap_rnd_compat_bits",
+		.data		= &mmap_rnd_compat_bits,
+		.maxlen		= sizeof(mmap_rnd_compat_bits),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= (void *)&mmap_rnd_compat_bits_min,
+		.extra2		= (void *)&mmap_rnd_compat_bits_max,
+	},
+#endif
 	{ }
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 455772a05e54..d99cef70ad18 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -58,6 +58,18 @@
 #define arch_rebalance_pgtables(addr, len)		(addr)
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
+const int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
+const int mmap_rnd_bits_max = CONFIG_ARCH_MMAP_RND_BITS_MAX;
+int mmap_rnd_bits __read_mostly = CONFIG_ARCH_MMAP_RND_BITS;
+#endif
+#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
+const int mmap_rnd_compat_bits_min = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN;
+const int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
+int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
+#endif
+
+
 static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
