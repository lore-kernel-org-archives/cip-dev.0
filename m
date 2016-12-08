From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Dec 2016 23:57:51 +0000
Subject: [cip-dev] [PATCH 4.4-cip 3/6] arm64: mm: support ARCH_MMAP_RND_BITS
In-Reply-To: <1481241380.1860.120.camel@codethink.co.uk>
References: <1481241380.1860.120.camel@codethink.co.uk>
Message-ID: <1481241471.1860.123.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Daniel Cashman <dcashman@google.com>

commit 8f0d3aa9de57662fe35d8bacfbd9d7ef85ffe98f upstream.

arm64: arch_mmap_rnd() uses STACK_RND_MASK to generate the random offset
for the mmap base address.  This value represents a compromise between
increased ASLR effectiveness and avoiding address-space fragmentation.
Replace it with a Kconfig option, which is sensibly bounded, so that
platform developers may choose where to place this compromise.  Keep
default values as new minimums.

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
 arch/arm64/Kconfig   | 29 +++++++++++++++++++++++++++++
 arch/arm64/mm/mmap.c |  8 ++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 14cdc6dea493..edf62be35adc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -51,6 +51,8 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP && !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
@@ -104,6 +106,33 @@ config ARCH_PHYS_ADDR_T_64BIT
 config MMU
 	def_bool y
 
+config ARCH_MMAP_RND_BITS_MIN
+       default 14 if ARM64_64K_PAGES
+       default 16 if ARM64_16K_PAGES
+       default 18
+
+# max bits determined by the following formula:
+#  VA_BITS - PAGE_SHIFT - 3
+config ARCH_MMAP_RND_BITS_MAX
+       default 19 if ARM64_VA_BITS=36
+       default 24 if ARM64_VA_BITS=39
+       default 27 if ARM64_VA_BITS=42
+       default 30 if ARM64_VA_BITS=47
+       default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
+       default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
+       default 33 if ARM64_VA_BITS=48
+       default 14 if ARM64_64K_PAGES
+       default 16 if ARM64_16K_PAGES
+       default 18
+
+config ARCH_MMAP_RND_COMPAT_BITS_MIN
+       default 7 if ARM64_64K_PAGES
+       default 9 if ARM64_16K_PAGES
+       default 11
+
+config ARCH_MMAP_RND_COMPAT_BITS_MAX
+       default 16
+
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index ed177475dd8c..4c893b5189dd 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -51,8 +51,12 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-	rnd = (unsigned long)get_random_int() & STACK_RND_MASK;
-
+#ifdef CONFIG_COMPAT
+	if (test_thread_flag(TIF_32BIT))
+		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_compat_bits) - 1);
+	else
+#endif
+		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
 	return rnd << PAGE_SHIFT;
 }
 
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
