From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:57 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 28/83] mmc: sh_mobile_sdhi: only change
	the clock on RCar Gen2+
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-29-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 8fc009986471729533fb1246c7ea9395635dac26 upstream.

We had a regression on r8a7740 where the SDHI clock was a generic
peripheral clock, so changing its rate was not desired. This should be
fixed in the clock driver. However, it also shows that the new clock
calculation should only be used on tested systems. Add a check for that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index efa4fca..d5e4000 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -172,6 +172,10 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	int i;
 
+	/* tested only on RCar Gen2+ currently; may work for others */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		return clk_get_rate(priv->clk);
+
 	/*
 	 * We want the bus clock to be as close as possible to, but no
 	 * greater than, new_clock.  As we can divide by 1 << i for
-- 
2.7.4
