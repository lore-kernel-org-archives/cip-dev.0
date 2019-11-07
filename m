From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:25 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 56/83] mmc: host: tmio: refactor calls
	to sdio irq
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-57-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e4f38eb18aedd098b3019e82df07f583a5cbcc58 upstream.

tmio_mmc_sdio_irq() is not used as a seperate irq handler anymore, so we
can make it similar to the other irq helper functions, namely:

* only give the host as argument function which is what it really needs
* prefix function name with __

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 9fe6d65..0a3f411 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -709,7 +709,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-static bool tmio_mmc_sdio_irq(int irq, void *devid)
+static bool __tmio_mmc_sdio_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
@@ -754,7 +754,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	if (tmio_mmc_sdio_irq(irq, devid))
+	if (__tmio_mmc_sdio_irq(irq, devid))
 		return IRQ_HANDLED;
 
 	return IRQ_NONE;
-- 
2.7.4
