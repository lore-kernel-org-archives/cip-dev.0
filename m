From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Dec 2016 23:57:35 +0000
Subject: [cip-dev] [PATCH 4.4-cip 2/6] arm: mm: support ARCH_MMAP_RND_BITS
In-Reply-To: <1481241380.1860.120.camel@codethink.co.uk>
References: <1481241380.1860.120.camel@codethink.co.uk>
Message-ID: <1481241455.1860.122.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Daniel Cashman <dcashman@google.com>

commit e0c25d958f78acfd5c97df5776eeba3e0684101b upstream.

arm: arch_mmap_rnd() uses a hard-code value of 8 to generate the random
offset for the mmap base address.  This value represents a compromise
between increased ASLR effectiveness and avoiding address-space
fragmentation.  Replace it with a Kconfig option, which is sensibly
bounded, so that platform developers may choose where to place this
compromise.  Keep 8 as the minimum acceptable value.

[arnd at arndb.de: ARM: avoid ARCH_MMAP_RND_BITS for NOMMU]
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/Kconfig   | 9 +++++++++
 arch/arm/mm/mmap.c | 3 +--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34e1569a11ee..a1b8ca129a8a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -35,6 +35,7 @@ config ARM
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32
+	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
@@ -308,6 +309,14 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
+config ARCH_MMAP_RND_BITS_MIN
+	default 8
+
+config ARCH_MMAP_RND_BITS_MAX
+	default 14 if PAGE_OFFSET=0x40000000
+	default 15 if PAGE_OFFSET=0x80000000
+	default 16
+
 #
 # The "ARM system type" choice list is ordered alphabetically by option
 # text.  Please add new entries in the option alphabetic order.
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 407dc786583a..4b4058db0781 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -173,8 +173,7 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-	/* 8 bits of randomness in 20 address space bits */
-	rnd = (unsigned long)get_random_int() % (1 << 8);
+	rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
 
 	return rnd << PAGE_SHIFT;
 }
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
