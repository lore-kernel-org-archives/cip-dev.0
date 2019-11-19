From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:36:06 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 27/31] mmc: host: tmio: don't BUG on
	unsupported stop commands
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-28-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 022f731e03d190d0e4f52f2b1bd90fae0eadd56d upstream.

Halting the kernel on an unsupported stop command seems overkill, report
the error and say what we already did (due to autocmd12) instead.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 3004d90..4faacd5 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -552,10 +552,11 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	}
 
 	if (stop) {
-		if (stop->opcode == MMC_STOP_TRANSMISSION && !stop->arg)
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
-		else
-			BUG();
+		if (stop->opcode != MMC_STOP_TRANSMISSION || stop->arg)
+			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12,0\n",
+				stop->opcode, stop->arg);
+
+		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 	}
 
 	schedule_work(&host->done);
-- 
2.7.4
