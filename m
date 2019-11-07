From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:35 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/83] mmc: tmio: disable clock before
	changing it
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 14d5828f4ebbfbe8e07d4d01eb85a684a9290243 upstream.

Rcar2 & 3 docs state that for going to and coming from the 0xff setting,
the clock must first be disabled before the DIV bits are changed.
Instead of tracking this, let's just do this unconditionally.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index bb09b51..2a3bbfd 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -174,6 +174,8 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	if (host->set_clk_div)
 		host->set_clk_div(host->pdev, (clk >> 22) & 1);
 
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
 		msleep(10);
-- 
2.7.4
