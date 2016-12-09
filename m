From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:36:08 +0000
Subject: [cip-dev] [PATCH 4.4-cip 12/23] blk-mq: fix undefined behaviour in
 order_to_size()
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243768.1860.168.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

commit b3a834b1596ac668df206aa2bb1f191c31f5f5e4 upstream.

When this_order variable in blk_mq_init_rq_map() becomes zero
the code incorrectly decrements the variable and passes the result
to order_to_size() helper causing undefined behaviour:

 UBSAN: Undefined behaviour in block/blk-mq.c:1459:27
 shift exponent 4294967295 is too large for 32-bit type 'unsigned int'
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc6-00072-g33656a1 #22

Fix the code by checking this_order variable for not having the zero
value first.

Reported-by: Meelis Roos <mroos@linux.ee>
Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3e461ec40e4..c58fdfdd9ea6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1494,7 +1494,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 		int to_do;
 		void *p;
 
-		while (left < order_to_size(this_order - 1) && this_order)
+		while (this_order && left < order_to_size(this_order - 1))
 			this_order--;
 
 		do {
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
