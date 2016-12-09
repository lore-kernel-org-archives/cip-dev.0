From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:34:44 +0000
Subject: [cip-dev] [PATCH 4.4-cip 05/23] mm/page-writeback: fix
 dirty_ratelimit calculation
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243684.1860.161.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit d59b1087a98e402ed9a7cc577f4da435f9a555f5 upstream.

Calculation of dirty_ratelimit sometimes is not correct.  E.g.  initial
values of dirty_ratelimit == INIT_BW and step == 0, lead to the
following result:

   UBSAN: Undefined behaviour in ../mm/page-writeback.c:1286:7
   shift exponent 25600 is too large for 64-bit type 'long unsigned int'

The fix is straightforward - make step 0 if the shift exponent is too
big.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 mm/page-writeback.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fd51ebfc423f..6d0dbde4503b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1162,6 +1162,7 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
 	unsigned long balanced_dirty_ratelimit;
 	unsigned long step;
 	unsigned long x;
+	unsigned long shift;
 
 	/*
 	 * The dirty rate will match the writeout rate in long term, except
@@ -1286,11 +1287,11 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
 	 * rate itself is constantly fluctuating. So decrease the track speed
 	 * when it gets close to the target. Helps eliminate pointless tremors.
 	 */
-	step >>= dirty_ratelimit / (2 * step + 1);
-	/*
-	 * Limit the tracking speed to avoid overshooting.
-	 */
-	step = (step + 7) / 8;
+	shift = dirty_ratelimit / (2 * step + 1);
+	if (shift < BITS_PER_LONG)
+		step = DIV_ROUND_UP(step >> shift, 8);
+	else
+		step = 0;
 
 	if (dirty_ratelimit < balanced_dirty_ratelimit)
 		dirty_ratelimit += step;
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
