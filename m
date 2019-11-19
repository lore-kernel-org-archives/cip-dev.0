From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:36:07 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 28/31] mmc: host: tmio: fill in response
	from auto cmd12
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-29-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit eb7c00e1461124ad0e85f1a9a3954d7164809c13 upstream.

After we received the dataend interrupt, R1 response register carries
the value from the automatically generated stop command. Report that
info back to the MMC block layer, so we will be notified in case of e.g.
ECC errors which happened during the last transfer.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4faacd5..163646f 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -556,6 +556,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12,0\n",
 				stop->opcode, stop->arg);
 
+		/* fill in response from auto CMD12 */
+		stop->resp[0] = sd_ctrl_read16_and_16_as_32(host, CTL_RESPONSE);
+
 		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 	}
 
-- 
2.7.4
