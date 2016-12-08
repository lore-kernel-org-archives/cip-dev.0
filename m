From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 08 Dec 2016 23:58:30 +0000
Subject: [cip-dev] [PATCH 4.4-cip 6/6] mm: ASLR: use get_random_long()
In-Reply-To: <1481241380.1860.120.camel@codethink.co.uk>
References: <1481241380.1860.120.camel@codethink.co.uk>
Message-ID: <1481241510.1860.126.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Daniel Cashman <dcashman@android.com>

commit 5ef11c35ce86b94bfb878b684de4cdaf96f54b2f upstream.

Replace calls to get_random_int() followed by a cast to (unsigned long)
with calls to get_random_long().  Also address shifting bug which, in
case of x86 removed entropy mask for mmap_rnd_bits values > 31 bits.

Signed-off-by: Daniel Cashman <dcashman@android.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nick Kralevich <nnk@google.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/mm/mmap.c               | 2 +-
 arch/arm64/mm/mmap.c             | 4 ++--
 arch/mips/mm/mmap.c              | 4 ++--
 arch/powerpc/kernel/process.c    | 4 ++--
 arch/powerpc/mm/mmap.c           | 4 ++--
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 arch/x86/mm/mmap.c               | 6 +++---
 fs/binfmt_elf.c                  | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 4b4058db0781..66353caa35b9 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -173,7 +173,7 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-	rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
+	rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
 
 	return rnd << PAGE_SHIFT;
 }
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 4c893b5189dd..232f787a088a 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -53,10 +53,10 @@ unsigned long arch_mmap_rnd(void)
 
 #ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT))
-		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_compat_bits) - 1);
+		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 	else
 #endif
-		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
+		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
 	return rnd << PAGE_SHIFT;
 }
 
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 5c81fdd032c3..353037699512 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -146,7 +146,7 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-	rnd = (unsigned long)get_random_int();
+	rnd = get_random_long();
 	rnd <<= PAGE_SHIFT;
 	if (TASK_IS_32BIT_ADDR)
 		rnd &= 0xfffffful;
@@ -174,7 +174,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 
 static inline unsigned long brk_rnd(void)
 {
-	unsigned long rnd = get_random_int();
+	unsigned long rnd = get_random_long();
 
 	rnd = rnd << PAGE_SHIFT;
 	/* 8MB for 32bit, 256MB for 64bit */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index cf788d7d7e56..b7abf3cd2a67 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1651,9 +1651,9 @@ static inline unsigned long brk_rnd(void)
 
 	/* 8MB for 32bit, 1GB for 64bit */
 	if (is_32bit_task())
-		rnd = (long)(get_random_int() % (1<<(23-PAGE_SHIFT)));
+		rnd = (get_random_long() % (1UL<<(23-PAGE_SHIFT)));
 	else
-		rnd = (long)(get_random_int() % (1<<(30-PAGE_SHIFT)));
+		rnd = (get_random_long() % (1UL<<(30-PAGE_SHIFT)));
 
 	return rnd << PAGE_SHIFT;
 }
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 0f0502e12f6c..4087705ba90f 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -59,9 +59,9 @@ unsigned long arch_mmap_rnd(void)
 
 	/* 8MB for 32bit, 1GB for 64bit */
 	if (is_32bit_task())
-		rnd = (unsigned long)get_random_int() % (1<<(23-PAGE_SHIFT));
+		rnd = get_random_long() % (1<<(23-PAGE_SHIFT));
 	else
-		rnd = (unsigned long)get_random_int() % (1<<(30-PAGE_SHIFT));
+		rnd = get_random_long() % (1UL<<(30-PAGE_SHIFT));
 
 	return rnd << PAGE_SHIFT;
 }
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index c690c8e16a96..b489e9759518 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -264,7 +264,7 @@ static unsigned long mmap_rnd(void)
 	unsigned long rnd = 0UL;
 
 	if (current->flags & PF_RANDOMIZE) {
-		unsigned long val = get_random_int();
+		unsigned long val = get_random_long();
 		if (test_thread_flag(TIF_32BIT))
 			rnd = (val % (1UL << (23UL-PAGE_SHIFT)));
 		else
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 389939f74dd5..d2dc0438d654 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -71,12 +71,12 @@ unsigned long arch_mmap_rnd(void)
 
 	if (mmap_is_ia32())
 #ifdef CONFIG_COMPAT
-		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_compat_bits) - 1);
+		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 #else
-		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
+		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
 #endif
 	else
-		rnd = (unsigned long)get_random_int() & ((1 << mmap_rnd_bits) - 1);
+		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
 
 	return rnd << PAGE_SHIFT;
 }
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3a93755e880f..0c52941dd62c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -651,7 +651,7 @@ static unsigned long randomize_stack_top(unsigned long stack_top)
 
 	if ((current->flags & PF_RANDOMIZE) &&
 		!(current->personality & ADDR_NO_RANDOMIZE)) {
-		random_variable = (unsigned long) get_random_int();
+		random_variable = get_random_long();
 		random_variable &= STACK_RND_MASK;
 		random_variable <<= PAGE_SHIFT;
 	}
-- 
2.10.2


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
