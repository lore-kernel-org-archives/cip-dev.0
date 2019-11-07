From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:29 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 60/83] mmc: host: tmio: use defines for
	CTL_STOP_INTERNAL_ACTION values
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-61-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 9afcbf4a6f1995f3b47088764eaef7b56154beb9 upstream.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     | 4 ++++
 drivers/mmc/host/tmio_mmc_pio.c | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index f864be46..3164e7c 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -49,6 +49,10 @@
 #define CTL_CLK_AND_WAIT_CTL 0x138
 #define CTL_RESET_SDIO 0x1e0
 
+/* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
+#define TMIO_STOP_STP		BIT(0)
+#define TMIO_STOP_SEC		BIT(8)
+
 /* Definitions for values the CTRL_STATUS register can take. */
 #define TMIO_STAT_CMDRESPEND    BIT(0)
 #define TMIO_STAT_DATAEND       BIT(2)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 2fecd22..477cac8 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -340,7 +340,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 
 	/* CMD12 is handled by hardware */
 	if (cmd->opcode == MMC_STOP_TRANSMISSION && !cmd->arg) {
-		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x001);
+		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_STP);
 		return 0;
 	}
 
@@ -367,7 +367,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	if (data) {
 		c |= DATA_PRESENT;
 		if (data->blocks > 1) {
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x100);
+			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_SEC);
 			c |= TRANSFER_MULTI;
 
 			/*
@@ -554,7 +554,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 
 	if (stop) {
 		if (stop->opcode == MMC_STOP_TRANSMISSION && !stop->arg)
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x000);
+			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 		else
 			BUG();
 	}
-- 
2.7.4
