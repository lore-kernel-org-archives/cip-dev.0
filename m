From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:36:01 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 22/31] mmc: host: tmio: refactor calls
	to sdio irq
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-23-git-send-email-biju.das@bp.renesas.com>
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
 drivers/mmc/host/tmio_mmc_pio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index eaed795..09574e5 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -708,9 +708,8 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-static bool tmio_mmc_sdio_irq(int irq, void *devid)
+static bool __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned int ireg, status;
@@ -753,7 +752,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	if (tmio_mmc_sdio_irq(irq, devid))
+	if (__tmio_mmc_sdio_irq(host))
 		return IRQ_HANDLED;
 
 	return IRQ_NONE;
-- 
2.7.4
