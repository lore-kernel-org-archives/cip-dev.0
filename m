From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:23 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 54/83] mmc: tmio: Remove redundant check
	of mmc->slot.cd_irq
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-55-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit efd7be7bfc8eb8942ba3dc319f323cfd0eda99e2 upstream.

To validate whether native hotplug needs to be used, the tmio driver checks
whether the mmc->slot.cd_irq has been successfully assigned.

This check is redundant at its current place in tmio_mmc_host_probe(), as
the mmc core assigns mmc->slot.cd_irq a valid value first when
mmc_gpiod_request_cd_irq() is called. Therefore, let's just remove the
check for now, as that also removes a layering violation of the tmio driver
accessing core specific data via ->slot.cd_irq.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4e38fcc..0f766f4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1178,8 +1178,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-				  mmc->caps & MMC_CAP_NONREMOVABLE ||
-				  mmc->slot.cd_irq >= 0);
+				  !mmc_card_is_removable(mmc));
 
 	/*
 	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
-- 
2.7.4
