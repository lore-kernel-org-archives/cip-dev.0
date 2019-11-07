From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:06 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 37/83] mmc: tmio: enhance illegal
	sequence handling
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-38-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

commit 96e0b2ba00ee5dacb12bed6585145ce784ec9153 upstream.

An illegal sequence command error may occur if there is a stopbit or
cmd_index error as well as a CRC error. The correct course of action
is to re-enable IRQs

An illegal sequence data error may occur if there is a CRC or stopbit
error,  or underrun. In this case set data->error correctly.

This is in preparation for enabling tuning support which relies on
differentiating between illegal sequence and other errors.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
[simon: broken out of a larger patch]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4d9e17a..c255af8 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -552,7 +552,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	schedule_work(&host->done);
 }
 
-static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
 	struct mmc_data *data;
 	spin_lock(&host->lock);
@@ -561,6 +561,9 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	if (!data)
 		goto out;
 
+	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
+	    stat & TMIO_STAT_TXUNDERRUN)
+		data->error = -EILSEQ;
 	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 		bool done = false;
@@ -609,8 +612,6 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 		goto out;
 	}
 
-	host->cmd = NULL;
-
 	/* This controller is sicker than the PXA one. Not only do we need to
 	 * drop the top 8 bits of the first response word, we also need to
 	 * modify the order of the response for short response command types.
@@ -630,14 +631,16 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 
 	if (stat & TMIO_STAT_CMDTIMEOUT)
 		cmd->error = -ETIMEDOUT;
-	else if (stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC)
+	else if ((stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC) ||
+		 stat & TMIO_STAT_STOPBIT_ERR ||
+		 stat & TMIO_STAT_CMD_IDX_ERR)
 		cmd->error = -EILSEQ;
 
 	/* If there is data to handle we enable data IRQs here, and
 	 * we will ultimatley finish the request in the data_end handler.
 	 * If theres no data or we encountered an error, finish now.
 	 */
-	if (host->data && !cmd->error) {
+	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
 			if (host->force_pio || !host->chan_rx)
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
@@ -698,7 +701,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	/* Data transfer completion */
 	if (ireg & TMIO_STAT_DATAEND) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
-		tmio_mmc_data_irq(host);
+		tmio_mmc_data_irq(host, status);
 		return true;
 	}
 
-- 
2.7.4
