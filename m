From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:16:34 +0000
Subject: [cip-dev] [PATCH 4.4-cip 5/5] mm/page_poisoning.c: allow for zero
	poisoning
In-Reply-To: <1481242503.1860.139.camel@codethink.co.uk>
References: <1481242503.1860.139.camel@codethink.co.uk>
Message-ID: <1481242594.1860.144.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laura Abbott <labbott@fedoraproject.org>

commit 1414c7f4f7d72d138fff35f00151d15749b5beda upstream.

By default, page poisoning uses a poison value (0xaa) on free.  If this
is changed to 0, the page is not only sanitized but zeroing on alloc
with __GFP_ZERO can be skipped as well.  The tradeoff is that detecting
corruption from the poisoning is harder to detect.  This feature also
cannot be used with hibernation since pages are not guaranteed to be
zeroed after hibernation.

Credit to Grsecurity/PaX team for inspiring this work

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
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
 include/linux/mm.h       |  2 ++
 include/linux/poison.h   |  4 ++++
 kernel/power/hibernate.c | 17 +++++++++++++++++
 mm/Kconfig.debug         | 14 ++++++++++++++
 mm/page_alloc.c          | 11 ++++++++++-
 mm/page_ext.c            | 10 ++++++++--
 mm/page_poison.c         |  7 +++++--
 7 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 56272e69c9a3..5d8beadd908d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2132,10 +2132,12 @@ static inline void vm_stat_account(struct mm_struct *mm,
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
+extern bool page_is_poisoned(struct page *page);
 #else
 static inline bool page_poisoning_enabled(void) { return false; }
 static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
+static inline bool page_is_poisoned(struct page *page) { return false; }
 #endif
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 317e16de09e5..199ffec4bdf3 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -30,7 +30,11 @@
 #define TIMER_ENTRY_STATIC	((void *) 0x74737461)
 
 /********** mm/debug-pagealloc.c **********/
+#ifdef CONFIG_PAGE_POISONING_ZERO
+#define PAGE_POISON 0x00
+#else
 #define PAGE_POISON 0xaa
+#endif
 
 /********** mm/slab.c **********/
 /*
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 3124cebaec31..2fc1177383a0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1159,6 +1159,22 @@ static int __init kaslr_nohibernate_setup(char *str)
 	return nohibernate_setup(str);
 }
 
+static int __init page_poison_nohibernate_setup(char *str)
+{
+#ifdef CONFIG_PAGE_POISONING_ZERO
+	/*
+	 * The zeroing option for page poison skips the checks on alloc.
+	 * since hibernation doesn't save free pages there's no way to
+	 * guarantee the pages will still be zeroed.
+	 */
+	if (!strcmp(str, "on")) {
+		pr_info("Disabling hibernation due to page poisoning\n");
+		return nohibernate_setup(str);
+	}
+#endif
+	return 1;
+}
+
 __setup("noresume", noresume_setup);
 __setup("resume_offset=", resume_offset_setup);
 __setup("resume=", resume_setup);
@@ -1167,3 +1183,4 @@ __setup("resumewait", resumewait_setup);
 __setup("resumedelay=", resumedelay_setup);
 __setup("nohibernate", nohibernate_setup);
 __setup("kaslr", kaslr_nohibernate_setup);
+__setup("page_poison=", page_poison_nohibernate_setup);
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 35d68954ad34..613437b03ebb 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -51,3 +51,17 @@ config PAGE_POISONING_NO_SANITY
 
 	   If you are only interested in sanitization, say Y. Otherwise
 	   say N.
+
+config PAGE_POISONING_ZERO
+	bool "Use zero for poisoning instead of random data"
+	depends on PAGE_POISONING
+	---help---
+	   Instead of using the existing poison value, fill the pages with
+	   zeros. This makes it harder to detect when errors are occurring
+	   due to sanitization but the zeroing at free means that it is
+	   no longer necessary to write zeros when GFP_ZERO is used on
+	   allocation.
+
+	   Enabling page poisoning with this option will disable hibernation
+
+	   If unsure, say N
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 94e98734ecd9..4b3b5cb36844 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1384,15 +1384,24 @@ static inline int check_new_page(struct page *page)
 	return 0;
 }
 
+static inline bool free_pages_prezeroed(bool poisoned)
+{
+	return IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) &&
+		page_poisoning_enabled() && poisoned;
+}
+
 static int prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 								int alloc_flags)
 {
 	int i;
+	bool poisoned = true;
 
 	for (i = 0; i < (1 << order); i++) {
 		struct page *p = page + i;
 		if (unlikely(check_new_page(p)))
 			return 1;
+		if (poisoned)
+			poisoned &= page_is_poisoned(p);
 	}
 
 	set_page_private(page, 0);
@@ -1403,7 +1412,7 @@ static int prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 	kernel_poison_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
 
-	if (gfp_flags & __GFP_ZERO)
+	if (!free_pages_prezeroed(poisoned) && (gfp_flags & __GFP_ZERO))
 		for (i = 0; i < (1 << order); i++)
 			clear_highpage(page + i);
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 292ca7b8debd..2d864e64f7fe 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -106,12 +106,15 @@ struct page_ext *lookup_page_ext(struct page *page)
 	struct page_ext *base;
 
 	base = NODE_DATA(page_to_nid(page))->node_page_ext;
-#ifdef CONFIG_DEBUG_VM
+#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PAGE_POISONING)
 	/*
 	 * The sanity checks the page allocator does upon freeing a
 	 * page can reach here before the page_ext arrays are
 	 * allocated when feeding a range of pages to the allocator
 	 * for the first time during bootup or memory hotplug.
+	 *
+	 * This check is also necessary for ensuring page poisoning
+	 * works as expected when enabled
 	 */
 	if (unlikely(!base))
 		return NULL;
@@ -180,12 +183,15 @@ struct page_ext *lookup_page_ext(struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct mem_section *section = __pfn_to_section(pfn);
-#ifdef CONFIG_DEBUG_VM
+#if defined(CONFIG_DEBUG_VM) || defined(CONFIG_PAGE_POISONING)
 	/*
 	 * The sanity checks the page allocator does upon freeing a
 	 * page can reach here before the page_ext arrays are
 	 * allocated when feeding a range of pages to the allocator
 	 * for the first time during bootup or memory hotplug.
+	 *
+	 * This check is also necessary for ensuring page poisoning
+	 * works as expected when enabled
 	 */
 	if (!section->page_ext)
 		return NULL;
diff --git a/mm/page_poison.c b/mm/page_poison.c
index 89d3bc773633..479e7ea2bea6 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -71,11 +71,14 @@ static inline void clear_page_poison(struct page *page)
 	__clear_bit(PAGE_EXT_DEBUG_POISON, &page_ext->flags);
 }
 
-static inline bool page_poison(struct page *page)
+bool page_is_poisoned(struct page *page)
 {
 	struct page_ext *page_ext;
 
 	page_ext = lookup_page_ext(page);
+	if (!page_ext)
+		return false;
+
 	return test_bit(PAGE_EXT_DEBUG_POISON, &page_ext->flags);
 }
 
@@ -137,7 +140,7 @@ static void unpoison_page(struct page *page)
 {
 	void *addr;
 
-	if (!page_poison(page))
+	if (!page_is_poisoned(page))
 		return;
 
 	addr = kmap_atomic(page);
-- 
2.10.2


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
