From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:01 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 32/83] mmc: host: sh_mobile_sdhi: don't
	populate unneeded functions
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-33-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ff026099d775c74548839f1d627eb0b2bec0b857 upstream.

Populating card_busy caused a side-effect on a chip variant we don't
have documentation for (r8a73a4). So, enable it and voltage switching
only on devices known to support those features.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 452e5eef6d31 ("mmc: tmio: Add UHS-I mode support")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 343aa1a..3d186cc 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -383,8 +383,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	host->clk_update	= sh_mobile_sdhi_clk_update;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
-	host->card_busy	= sh_mobile_sdhi_card_busy;
-	host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
+
+	/* SDR speeds are only available on Gen2+ */
+	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
+		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
+		host->card_busy	= sh_mobile_sdhi_card_busy;
+		host->start_signal_voltage_switch =
+			sh_mobile_sdhi_start_signal_voltage_switch;
+	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
 	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
-- 
2.7.4
