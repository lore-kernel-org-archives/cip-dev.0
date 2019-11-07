From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:39 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 10/83] mmc: tmio,
	sh_mobile_sdhi: Pass tmio_mmc_host ptr to clk_{enable, disable} ops
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 0ea28210c15680bbabc3d6079f771f1a1e69509a upstream.

Change the clk_enable operation to take a pointer to the struct
tmio_mmc_host and have it set f_max.  For consistency, also change the
clk_disable operation to take a pointer to struct tmio_mmc_host.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 12 +++++-------
 drivers/mmc/host/tmio_mmc.h       |  4 ++--
 drivers/mmc/host/tmio_mmc_pio.c   |  4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 90d042d..3b9cd2b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -132,16 +132,15 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 	sd_ctrl_write16(host, EXT_ACC, val);
 }
 
-static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int *f)
+static int sh_mobile_sdhi_clk_enable(struct tmio_mmc_host *host)
 {
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mmc_host *mmc = host->mmc;
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	int ret = clk_prepare_enable(priv->clk);
 	if (ret < 0)
 		return ret;
 
-	*f = clk_get_rate(priv->clk);
+	mmc->f_max = clk_get_rate(priv->clk);
 
 	/* enable 16bit data access on SDBUF as default */
 	sh_mobile_sdhi_sdbuf_width(host, 16);
@@ -149,11 +148,10 @@ static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int
 	return 0;
 }
 
-static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
+static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 {
-	struct mmc_host *mmc = platform_get_drvdata(pdev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
+
 	clk_disable_unprepare(priv->clk);
 }
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 4a597f5a..68fd8d7 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -95,8 +95,8 @@ struct tmio_mmc_host {
 	bool			sdio_irq_enabled;
 
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
-	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
-	void (*clk_disable)(struct platform_device *pdev);
+	int (*clk_enable)(struct tmio_mmc_host *host);
+	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 };
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 2a3bbfd..f7a9fa6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -843,7 +843,7 @@ static int tmio_mmc_clk_update(struct tmio_mmc_host *host)
 	if (!host->clk_enable)
 		return -ENOTSUPP;
 
-	ret = host->clk_enable(host->pdev, &mmc->f_max);
+	ret = host->clk_enable(host);
 	if (!ret)
 		mmc->f_min = mmc->f_max / 512;
 
@@ -1249,7 +1249,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 		tmio_mmc_clk_stop(host);
 
 	if (host->clk_disable)
-		host->clk_disable(host->pdev);
+		host->clk_disable(host);
 
 	return 0;
 }
-- 
2.7.4
