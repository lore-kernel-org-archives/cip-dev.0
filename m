From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:16:00 +0000
Subject: [cip-dev] [PATCH 4.4-cip 2/5] mm/slab: use more appropriate
 condition check for debug_pagealloc
In-Reply-To: <1481242503.1860.139.camel@codethink.co.uk>
References: <1481242503.1860.139.camel@codethink.co.uk>
Message-ID: <1481242560.1860.141.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

commit 40323278b557a5909bbecfa181c91a3af7afbbe3 upstream.

debug_pagealloc debugging is related to SLAB_POISON flag rather than
FORCED_DEBUG option, although FORCED_DEBUG option will enable
SLAB_POISON.  Fix it.

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
 mm/slab.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ed7eb6c92c81..62a7e4d3dde3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2180,7 +2180,6 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 		else
 			size += BYTES_PER_WORD;
 	}
-#if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	/*
 	 * To activate debug pagealloc, off-slab management is necessary
 	 * requirement. In early phase of initialization, small sized slab
@@ -2188,7 +2187,7 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 	 * to check size >= 256. It guarantees that all necessary small
 	 * sized slab is initialized in current slab initialization sequence.
 	 */
-	if (debug_pagealloc_enabled() &&
+	if (debug_pagealloc_enabled() && (flags & SLAB_POISON) &&
 		!slab_early_init && size >= kmalloc_size(INDEX_NODE) &&
 		size >= 256 && cachep->object_size > cache_line_size() &&
 		ALIGN(size, cachep->align) < PAGE_SIZE) {
@@ -2196,7 +2195,6 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 		size = PAGE_SIZE;
 	}
 #endif
-#endif
 
 	/*
 	 * Determine if the slab management is 'on' or 'off' slab.
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
