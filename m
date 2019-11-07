From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:46 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 17/83] mmc: sh_mobile_sdhi: remove
	obsolete irq_by_name registration
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit adcbc949046366edb46e44f72ac9197c32675cfd upstream.

There is no user left in the kernel, so this code can be removed.
(Legacy, non-DT sh_mobile boards have been removed a while ago.) The

diff looks more complicated than it is: The if-block for multiplexed isr
is now the main code path, the rest is removed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 57 ++++++---------------------------------
 1 file changed, 8 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d6035b4..ea78c77 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -28,7 +28,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
@@ -318,7 +317,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_host *host;
 	struct resource *res;
 	int irq, ret, i = 0;
-	bool multiplexed_isr = true;
 	struct tmio_mmc_dma *dma_priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -410,62 +408,23 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
-	/*
-	 * Allow one or more specific (named) ISRs or
-	 * one or more multiplexed (un-named) ISRs.
-	 */
-
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_card_detect_irq, 0,
+	while (1) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			break;
+		i++;
+		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				  dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
 
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdio_irq, 0,
-				  dev_name(&pdev->dev), host);
-		if (ret)
-			goto eirq;
-	}
-
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdcard_irq, 0,
-				  dev_name(&pdev->dev), host);
-		if (ret)
-			goto eirq;
-	} else if (!multiplexed_isr) {
-		dev_err(&pdev->dev,
-			"Principal SD-card IRQ is missing among named interrupts\n");
+	/* There must be at least one IRQ source */
+	if (!i) {
 		ret = irq;
 		goto eirq;
 	}
 
-	if (multiplexed_isr) {
-		while (1) {
-			irq = platform_get_irq(pdev, i);
-			if (irq < 0)
-				break;
-			i++;
-			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
-					  dev_name(&pdev->dev), host);
-			if (ret)
-				goto eirq;
-		}
-
-		/* There must be at least one IRQ source */
-		if (!i) {
-			ret = irq;
-			goto eirq;
-		}
-	}
-
 	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
-- 
2.7.4
