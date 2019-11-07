From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:14 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 45/83] mmc: tmio: use SDIO master
	interrupt bit only when allowed
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-46-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c51ff6c6180e76a1ba96aef799a9c41aa80fcc95 upstream.

The master bit to enable SDIO interrupts can only be accessed if
SCLKDIVEN bit allows that. However, the core uses the SDIO enable
callback at times when SCLKDIVEN forbids the change. This leads to
"timeout waiting for SD bus idle" messages.

We now activate the master bit in probe once if SDIO is supported. IRQ
en-/disabling will be done now by the individual IRQ enablement bits
only.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yasushi SHOJI <yashi@atmark-techno.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index fee72a9..87f7aa7 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -140,12 +140,10 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
 					~TMIO_SDIO_STAT_IOIRQ;
-		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 	} else if (!enable && host->sdio_irq_enabled) {
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
-		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
 
 		host->sdio_irq_enabled = false;
 		pm_runtime_mark_last_busy(mmc_dev(mmc));
@@ -1235,7 +1233,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 		sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
-		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0000);
+		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0001);
 	}
 
 	spin_lock_init(&_host->lock);
@@ -1283,6 +1281,9 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	struct platform_device *pdev = host->pdev;
 	struct mmc_host *mmc = host->mmc;
 
+	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ)
+		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
+
 	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
 
-- 
2.7.4
