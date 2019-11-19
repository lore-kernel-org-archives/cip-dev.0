From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:36:00 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 21/31] mmc: host: tmio: disable clocks
	when unbinding
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-22-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit dfcba5ffca989749d1fc49d5b82a2d007b1295b7 upstream.

Create a helper function to disable clocks and use it in remove(), too.
Now, clk_summary in debugfs reports the clocks as disabled and
unprepared after unbinding.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 14a094c..eaed795 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -902,6 +902,12 @@ static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
 	return host->clk_enable(host);
 }
 
+static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
+{
+	if (host->clk_disable)
+		host->clk_disable(host);
+}
+
 static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -1286,6 +1292,8 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	tmio_mmc_clk_disable(host);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
@@ -1300,8 +1308,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	if (host->clk_cache)
 		tmio_mmc_clk_stop(host);
 
-	if (host->clk_disable)
-		host->clk_disable(host);
+	tmio_mmc_clk_disable(host);
 
 	return 0;
 }
-- 
2.7.4
