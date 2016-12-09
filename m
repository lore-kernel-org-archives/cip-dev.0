From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:16:22 +0000
Subject: [cip-dev] [PATCH 4.4-cip 4/5] mm/page_poison.c: enable
 PAGE_POISONING as a separate option
In-Reply-To: <1481242503.1860.139.camel@codethink.co.uk>
References: <1481242503.1860.139.camel@codethink.co.uk>
Message-ID: <1481242582.1860.143.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laura Abbott <labbott@fedoraproject.org>

commit 8823b1dbc05fab1a8bec275eeae4709257c2661d upstream.

Page poisoning is currently set up as a feature if architectures don't
have architecture debug page_alloc to allow unmapping of pages.  It has
uses apart from that though.  Clearing of the pages on free provides an
increase in security as it helps to limit the risk of information leaks.
Allow page poisoning to be enabled as a separate option independent of
kernel_map pages since the two features do separate work.  Because of
how hiberanation is implemented, the checks on alloc cannot occur if
hibernation is enabled.  The runtime alloc checks can also be enabled
with an option when !HIBERNATION.

Credit to Grsecurity/PaX team for inspiring this work

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Jianyu Zhan <nasa4836@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 Documentation/kernel-parameters.txt     |  5 +++
 include/linux/mm.h                      |  9 +++++
 mm/Kconfig.debug                        | 25 +++++++++++++-
 mm/Makefile                             |  2 +-
 mm/page_alloc.c                         |  2 ++
 mm/{debug-pagealloc.c => page_poison.c} | 60 ++++++++++++++++++++++++++-------
 6 files changed, 89 insertions(+), 14 deletions(-)
 rename mm/{debug-pagealloc.c => page_poison.c} (67%)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c360f80c3473..37180e331185 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2672,6 +2672,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			we can turn it on.
 			on: enable the feature
 
+	page_poison=	[KNL] Boot-time parameter changing the state of
+			poisoning on the buddy allocator.
+			off: turn off poisoning
+			on: turn on poisoning
+
 	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
 			timeout = 0: wait forever
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b93d147439f9..56272e69c9a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2129,6 +2129,15 @@ static inline void vm_stat_account(struct mm_struct *mm,
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_PAGE_POISONING
+extern bool page_poisoning_enabled(void);
+extern void kernel_poison_pages(struct page *page, int numpages, int enable);
+#else
+static inline bool page_poisoning_enabled(void) { return false; }
+static inline void kernel_poison_pages(struct page *page, int numpages,
+					int enable) { }
+#endif
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 extern bool _debug_pagealloc_enabled;
 extern void __kernel_map_pages(struct page *page, int numpages, int enable);
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 957d3da53ddd..35d68954ad34 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -27,4 +27,27 @@ config DEBUG_PAGEALLOC
 	  a resume because free pages are not saved to the suspend image.
 
 config PAGE_POISONING
-	bool
+	bool "Poison pages after freeing"
+	select PAGE_EXTENSION
+	select PAGE_POISONING_NO_SANITY if HIBERNATION
+	---help---
+	  Fill the pages with poison patterns after free_pages() and verify
+	  the patterns before alloc_pages. The filling of the memory helps
+	  reduce the risk of information leaks from freed data. This does
+	  have a potential performance impact.
+
+	  Note that "poison" here is not the same thing as the "HWPoison"
+	  for CONFIG_MEMORY_FAILURE. This is software poisoning only.
+
+	  If unsure, say N
+
+config PAGE_POISONING_NO_SANITY
+	depends on PAGE_POISONING
+	bool "Only poison, don't sanity check"
+	---help---
+	   Skip the sanity checking on alloc, only fill the pages with
+	   poison on free. This reduces some of the overhead of the
+	   poisoning feature.
+
+	   If you are only interested in sanitization, say Y. Otherwise
+	   say N.
diff --git a/mm/Makefile b/mm/Makefile
index 2ed43191fc3b..cfdd481d27a5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_KSM) += ksm.o
-obj-$(CONFIG_PAGE_POISONING) += debug-pagealloc.o
+obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KMEMCHECK) += kmemcheck.o
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2bcdfbf8c36d..94e98734ecd9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1004,6 +1004,7 @@ static bool free_pages_prepare(struct page *page, unsigned int order)
 					   PAGE_SIZE << order);
 	}
 	arch_free_page(page, order);
+	kernel_poison_pages(page, 1 << order, 0);
 	kernel_map_pages(page, 1 << order, 0);
 
 	return true;
@@ -1399,6 +1400,7 @@ static int prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 
 	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
+	kernel_poison_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
 
 	if (gfp_flags & __GFP_ZERO)
diff --git a/mm/debug-pagealloc.c b/mm/page_poison.c
similarity index 67%
rename from mm/debug-pagealloc.c
rename to mm/page_poison.c
index 5bf5906ce13b..89d3bc773633 100644
--- a/mm/debug-pagealloc.c
+++ b/mm/page_poison.c
@@ -6,22 +6,48 @@
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
 
-static bool page_poisoning_enabled __read_mostly;
+static bool __page_poisoning_enabled __read_mostly;
+static bool want_page_poisoning __read_mostly;
 
-static bool need_page_poisoning(void)
+static int early_page_poison_param(char *buf)
 {
-	if (!debug_pagealloc_enabled())
-		return false;
+	if (!buf)
+		return -EINVAL;
+
+	if (strcmp(buf, "on") == 0)
+		want_page_poisoning = true;
+	else if (strcmp(buf, "off") == 0)
+		want_page_poisoning = false;
 
-	return true;
+	return 0;
+}
+early_param("page_poison", early_page_poison_param);
+
+bool page_poisoning_enabled(void)
+{
+	return __page_poisoning_enabled;
+}
+
+static bool need_page_poisoning(void)
+{
+	return want_page_poisoning;
 }
 
 static void init_page_poisoning(void)
 {
-	if (!debug_pagealloc_enabled())
-		return;
+	/*
+	 * page poisoning is debug page alloc for some arches. If either
+	 * of those options are enabled, enable poisoning
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC)) {
+		if (!want_page_poisoning && !debug_pagealloc_enabled())
+			return;
+	} else {
+		if (!want_page_poisoning)
+			return;
+	}
 
-	page_poisoning_enabled = true;
+	__page_poisoning_enabled = true;
 }
 
 struct page_ext_operations page_poisoning_ops = {
@@ -83,6 +109,9 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
 	unsigned char *start;
 	unsigned char *end;
 
+	if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY))
+		return;
+
 	start = memchr_inv(mem, PAGE_POISON, bytes);
 	if (!start)
 		return;
@@ -95,9 +124,9 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
 	if (!__ratelimit(&ratelimit))
 		return;
 	else if (start == end && single_bit_flip(*start, PAGE_POISON))
-		printk(KERN_ERR "pagealloc: single bit error\n");
+		pr_err("pagealloc: single bit error\n");
 	else
-		printk(KERN_ERR "pagealloc: memory corruption\n");
+		pr_err("pagealloc: memory corruption\n");
 
 	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1, start,
 			end - start + 1, 1);
@@ -125,9 +154,9 @@ static void unpoison_pages(struct page *page, int n)
 		unpoison_page(page + i);
 }
 
-void __kernel_map_pages(struct page *page, int numpages, int enable)
+void kernel_poison_pages(struct page *page, int numpages, int enable)
 {
-	if (!page_poisoning_enabled)
+	if (!page_poisoning_enabled())
 		return;
 
 	if (enable)
@@ -135,3 +164,10 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 	else
 		poison_pages(page, numpages);
 }
+
+#ifndef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	/* This function does nothing, all work is done via poison pages */
+}
+#endif
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
