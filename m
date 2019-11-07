From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:58 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 29/83] mmc: sh_mobile_sdhi: check return
	value when changing clk
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-30-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit f3f44d512cafef7e3d2cb140f642786dd6ec8818 upstream.

And return the old clock rate if something went wrong.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d5e4000..814391b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -170,7 +170,7 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 {
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
-	int i;
+	int i, ret;
 
 	/* tested only on RCar Gen2+ currently; may work for others */
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
@@ -199,9 +199,9 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 		}
 	}
 
-	clk_set_rate(priv->clk, best_freq);
+	ret = clk_set_rate(priv->clk, best_freq);
 
-	return best_freq;
+	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
 static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
-- 
2.7.4
