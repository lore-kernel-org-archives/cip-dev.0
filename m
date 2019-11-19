From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:43 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/31] mmc: tmio: document mandatory and
	optional callbacks
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 2f87365f832bbc26e32f23588aaeb40abe15ff0d upstream.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c4131d9..d3d24e1 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -154,8 +154,10 @@ struct tmio_mmc_host {
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
 
-	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
+
+	/* Optional callbacks */
 	unsigned int (*clk_update)(struct tmio_mmc_host *host,
 				   unsigned int new_clock);
 	void (*clk_disable)(struct tmio_mmc_host *host);
@@ -164,6 +166,7 @@ struct tmio_mmc_host {
 	int (*card_busy)(struct mmc_host *mmc);
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
+	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
-- 
2.7.4
