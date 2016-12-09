From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:16:08 +0000
Subject: [cip-dev] [PATCH 4.4-cip 3/5] mm/slab: clean up DEBUG_PAGEALLOC
 processing code
In-Reply-To: <1481242503.1860.139.camel@codethink.co.uk>
References: <1481242503.1860.139.camel@codethink.co.uk>
Message-ID: <1481242568.1860.142.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

commit 40b44137971c2e5865a78f9f7de274449983ccb5 upstream.

Currently, open code for checking DEBUG_PAGEALLOC cache is spread to
some sites.  It makes code unreadable and hard to change.

This patch cleans up this code.  The following patch will change the
criteria for DEBUG_PAGEALLOC cache so this clean-up will help it, too.

[akpm at linux-foundation.org: fix build with CONFIG_DEBUG_PAGEALLOC=n]
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 include/linux/mm.h | 12 ++++---
 mm/slab.c          | 97 +++++++++++++++++++++++++++---------------------------
 2 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0ffa01c90d9..b93d147439f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2148,14 +2148,18 @@ kernel_map_pages(struct page *page, int numpages, int enable)
 }
 #ifdef CONFIG_HIBERNATION
 extern bool kernel_page_present(struct page *page);
-#endif /* CONFIG_HIBERNATION */
-#else
+#endif	/* CONFIG_HIBERNATION */
+#else	/* CONFIG_DEBUG_PAGEALLOC */
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 #ifdef CONFIG_HIBERNATION
 static inline bool kernel_page_present(struct page *page) { return true; }
-#endif /* CONFIG_HIBERNATION */
-#endif
+#endif	/* CONFIG_HIBERNATION */
+static inline bool debug_pagealloc_enabled(void)
+{
+	return false;
+}
+#endif	/* CONFIG_DEBUG_PAGEALLOC */
 
 #ifdef __HAVE_ARCH_GATE_AREA
 extern struct vm_area_struct *get_gate_vma(struct mm_struct *mm);
diff --git a/mm/slab.c b/mm/slab.c
index 62a7e4d3dde3..aa11af56f139 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1670,6 +1670,14 @@ static void kmem_rcu_free(struct rcu_head *head)
 }
 
 #if DEBUG
+static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
+{
+	if (debug_pagealloc_enabled() && OFF_SLAB(cachep) &&
+		(cachep->size % PAGE_SIZE) == 0)
+		return true;
+
+	return false;
+}
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
@@ -1703,6 +1711,23 @@ static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
 	}
 	*addr++ = 0x87654321;
 }
+
+static void slab_kernel_map(struct kmem_cache *cachep, void *objp,
+				int map, unsigned long caller)
+{
+	if (!is_debug_pagealloc_cache(cachep))
+		return;
+
+	if (caller)
+		store_stackinfo(cachep, objp, caller);
+
+	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
+}
+
+#else
+static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
+				int map, unsigned long caller) {}
+
 #endif
 
 static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
@@ -1781,6 +1806,9 @@ static void check_poison_obj(struct kmem_cache *cachep, void *objp)
 	int size, i;
 	int lines = 0;
 
+	if (is_debug_pagealloc_cache(cachep))
+		return;
+
 	realobj = (char *)objp + obj_offset(cachep);
 	size = cachep->object_size;
 
@@ -1846,17 +1874,8 @@ static void slab_destroy_debugcheck(struct kmem_cache *cachep,
 		void *objp = index_to_obj(cachep, page, i);
 
 		if (cachep->flags & SLAB_POISON) {
-#ifdef CONFIG_DEBUG_PAGEALLOC
-			if (debug_pagealloc_enabled() &&
-				cachep->size % PAGE_SIZE == 0 &&
-					OFF_SLAB(cachep))
-				kernel_map_pages(virt_to_page(objp),
-					cachep->size / PAGE_SIZE, 1);
-			else
-				check_poison_obj(cachep, objp);
-#else
 			check_poison_obj(cachep, objp);
-#endif
+			slab_kernel_map(cachep, objp, 1, 0);
 		}
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
@@ -2237,16 +2256,6 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 	if (flags & CFLGS_OFF_SLAB) {
 		/* really off slab. No need for manual alignment */
 		freelist_size = calculate_freelist_size(cachep->num, 0);
-
-#ifdef CONFIG_PAGE_POISONING
-		/* If we're going to use the generic kernel_map_pages()
-		 * poisoning, then it's going to smash the contents of
-		 * the redzone and userword anyhow, so switch them off.
-		 */
-		if (debug_pagealloc_enabled() &&
-			size % PAGE_SIZE == 0 && flags & SLAB_POISON)
-			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
-#endif
 	}
 
 	cachep->colour_off = cache_line_size();
@@ -2262,7 +2271,19 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 	cachep->size = size;
 	cachep->reciprocal_buffer_size = reciprocal_value(size);
 
-	if (flags & CFLGS_OFF_SLAB) {
+#if DEBUG
+	/*
+	 * If we're going to use the generic kernel_map_pages()
+	 * poisoning, then it's going to smash the contents of
+	 * the redzone and userword anyhow, so switch them off.
+	 */
+	if (IS_ENABLED(CONFIG_PAGE_POISONING) &&
+		(cachep->flags & SLAB_POISON) &&
+		is_debug_pagealloc_cache(cachep))
+		cachep->flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
+#endif
+
+	if (OFF_SLAB(cachep)) {
 		cachep->freelist_cache = kmalloc_slab(freelist_size, 0u);
 		/*
 		 * This is a possibility for one of the kmalloc_{dma,}_caches.
@@ -2489,9 +2510,6 @@ static void cache_init_objs(struct kmem_cache *cachep,
 	for (i = 0; i < cachep->num; i++) {
 		void *objp = index_to_obj(cachep, page, i);
 #if DEBUG
-		/* need to poison the objs? */
-		if (cachep->flags & SLAB_POISON)
-			poison_obj(cachep, objp, POISON_FREE);
 		if (cachep->flags & SLAB_STORE_USER)
 			*dbg_userword(cachep, objp) = NULL;
 
@@ -2515,10 +2533,11 @@ static void cache_init_objs(struct kmem_cache *cachep,
 				slab_error(cachep, "constructor overwrote the"
 					   " start of an object");
 		}
-		if ((cachep->size % PAGE_SIZE) == 0 &&
-			    OFF_SLAB(cachep) && cachep->flags & SLAB_POISON)
-			kernel_map_pages(virt_to_page(objp),
-					 cachep->size / PAGE_SIZE, 0);
+		/* need to poison the objs? */
+		if (cachep->flags & SLAB_POISON) {
+			poison_obj(cachep, objp, POISON_FREE);
+			slab_kernel_map(cachep, objp, 0, 0);
+		}
 #else
 		if (cachep->ctor)
 			cachep->ctor(objp);
@@ -2737,18 +2756,8 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 
 	set_obj_status(page, objnr, OBJECT_FREE);
 	if (cachep->flags & SLAB_POISON) {
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		if (debug_pagealloc_enabled() &&
-			(cachep->size % PAGE_SIZE) == 0 && OFF_SLAB(cachep)) {
-			store_stackinfo(cachep, objp, caller);
-			kernel_map_pages(virt_to_page(objp),
-					 cachep->size / PAGE_SIZE, 0);
-		} else {
-			poison_obj(cachep, objp, POISON_FREE);
-		}
-#else
 		poison_obj(cachep, objp, POISON_FREE);
-#endif
+		slab_kernel_map(cachep, objp, 0, caller);
 	}
 	return objp;
 }
@@ -2875,16 +2884,8 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 	if (!objp)
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		if (debug_pagealloc_enabled() &&
-			(cachep->size % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
-			kernel_map_pages(virt_to_page(objp),
-					 cachep->size / PAGE_SIZE, 1);
-		else
-			check_poison_obj(cachep, objp);
-#else
 		check_poison_obj(cachep, objp);
-#endif
+		slab_kernel_map(cachep, objp, 1, 0);
 		poison_obj(cachep, objp, POISON_INUSE);
 	}
 	if (cachep->flags & SLAB_STORE_USER)
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
