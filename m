From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:49 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 10/31] mmc: tmio: remove SDIO from TODO
	list
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e726e8c959fc735473f248e142de4d4f77ed342b upstream.

We surely have SDIO support by now :)

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 5460fda..13afe1f 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -22,7 +22,6 @@
  * TODO:
  *   Investigate using a workqueue for PIO transfers
  *   Eliminate FIXMEs
- *   SDIO support
  *   Better Power management
  *   Handle MMC errors better
  *   double buffer support
-- 
2.7.4
