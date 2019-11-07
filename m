From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:54 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 25/83] mmc: tmio: document CTL_STATUS
	handling
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-26-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 184adf202bca05ca34380cb53b349307aede7ef3 upstream.

Now that reading CTL_STATUS is consistent, we can remove CTL_STATUS2 and
document how this is handled internally.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8dd5ea4..1aac2ad 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -30,8 +30,9 @@
 #define CTL_STOP_INTERNAL_ACTION 0x08
 #define CTL_XFER_BLK_COUNT 0xa
 #define CTL_RESPONSE 0x0c
+/* driver merges STATUS and following STATUS2 */
 #define CTL_STATUS 0x1c
-#define CTL_STATUS2 0x1e
+/* driver merges IRQ_MASK and following IRQ_MASK2 */
 #define CTL_IRQ_MASK 0x20
 #define CTL_SD_CARD_CLK_CTL 0x24
 #define CTL_SD_XFER_LEN 0x26
-- 
2.7.4
