From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:15:47 +0000
Subject: [cip-dev] [PATCH 4.4-cip 1/5] mm/slab: activate debug_pagealloc in
 SLAB when it is actually enabled
In-Reply-To: <1481242503.1860.139.camel@codethink.co.uk>
References: <1481242503.1860.139.camel@codethink.co.uk>
Message-ID: <1481242547.1860.140.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

commit a307ebd468e0b97c203f5a99a56a6017e4d1991a upstream.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 mm/slab.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 4765c97ce690..ed7eb6c92c81 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1847,7 +1847,8 @@ static void slab_destroy_debugcheck(struct kmem_cache *cachep,
 
 		if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-			if (cachep->size % PAGE_SIZE == 0 &&
+			if (debug_pagealloc_enabled() &&
+				cachep->size % PAGE_SIZE == 0 &&
 					OFF_SLAB(cachep))
 				kernel_map_pages(virt_to_page(objp),
 					cachep->size / PAGE_SIZE, 1);
@@ -2187,7 +2188,8 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 	 * to check size >= 256. It guarantees that all necessary small
 	 * sized slab is initialized in current slab initialization sequence.
 	 */
-	if (!slab_early_init && size >= kmalloc_size(INDEX_NODE) &&
+	if (debug_pagealloc_enabled() &&
+		!slab_early_init && size >= kmalloc_size(INDEX_NODE) &&
 		size >= 256 && cachep->object_size > cache_line_size() &&
 		ALIGN(size, cachep->align) < PAGE_SIZE) {
 		cachep->obj_offset += PAGE_SIZE - ALIGN(size, cachep->align);
@@ -2243,7 +2245,8 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 		 * poisoning, then it's going to smash the contents of
 		 * the redzone and userword anyhow, so switch them off.
 		 */
-		if (size % PAGE_SIZE == 0 && flags & SLAB_POISON)
+		if (debug_pagealloc_enabled() &&
+			size % PAGE_SIZE == 0 && flags & SLAB_POISON)
 			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 #endif
 	}
@@ -2737,7 +2740,8 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 	set_obj_status(page, objnr, OBJECT_FREE);
 	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-		if ((cachep->size % PAGE_SIZE)==0 && OFF_SLAB(cachep)) {
+		if (debug_pagealloc_enabled() &&
+			(cachep->size % PAGE_SIZE) == 0 && OFF_SLAB(cachep)) {
 			store_stackinfo(cachep, objp, caller);
 			kernel_map_pages(virt_to_page(objp),
 					 cachep->size / PAGE_SIZE, 0);
@@ -2874,7 +2878,8 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
-		if ((cachep->size % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
+		if (debug_pagealloc_enabled() &&
+			(cachep->size % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
 			kernel_map_pages(virt_to_page(objp),
 					 cachep->size / PAGE_SIZE, 1);
 		else
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
