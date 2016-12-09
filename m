From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:35:58 +0000
Subject: [cip-dev] [PATCH 4.4-cip 11/23] btrfs: fix int32 overflow in
 shrink_delalloc().
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243758.1860.167.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Adam Borowski <kilobyte@angband.pl>

commit 8eb0dfdbda3f56bf7d248ed87fcc383df114ecbb upstream.

UBSAN: Undefined behaviour in fs/btrfs/extent-tree.c:4623:21
signed integer overflow:
10808 * 262144 cannot be represented in type 'int [8]'

If 8192<=items<16384, we request a writeback of an insane number of pages
which is benign (everything will be written).  But if items>=16384, the
space reservation won't be enough.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47cdc6f3390b..a4d7dbe2619e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4568,7 +4568,7 @@ static void shrink_delalloc(struct btrfs_root *root, u64 to_reclaim, u64 orig,
 
 	/* Calc the number of the pages we need flush for space reservation */
 	items = calc_reclaim_items_nr(root, to_reclaim);
-	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	to_reclaim = (u64)items * EXTENT_SIZE_PER_ITEM;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	block_rsv = &root->fs_info->delalloc_block_rsv;
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
