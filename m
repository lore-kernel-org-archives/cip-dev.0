From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:30 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 01/83] mmc: tmio_mmc_dma: don't print
	invalid DMA cookie
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Arnd Bergmann <arnd@arndb.de>

commit d50f42384dbfcf5143de614710e132dc06cd2439 upstream.

The tmio_mmc_start_dma_{rx,tx} function functions contain debug
code that prints the dma cookie among other things. However,
in case we fall back to PIO mode for some reason, the cookie
variable is never initialized, and gcc warns about this:

In file included from ../include/linux/printk.h:277:0,
                 from ../include/linux/kernel.h:13,
                 from ../include/linux/list.h:8,
                 from ../include/linux/kobject.h:20,
                 from ../include/linux/device.h:17,
                 from ../drivers/mmc/host/tmio_mmc_dma.c:13:
../drivers/mmc/host/tmio_mmc_dma.c: In function 'tmio_mmc_start_dma':
../include/linux/dynamic_debug.h:86:3: warning: 'cookie' may be used uninitialized in this function [-Wmaybe-uninitialized]
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
   ^
../drivers/mmc/host/tmio_mmc_dma.c:128:15: note: 'cookie' was declared here
  dma_cookie_t cookie;

This modifies the dev_dbg() statements so we only print the cookie
when we are already in the DMA path.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_dma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index e4b05db..4a0d6b8 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -94,9 +94,9 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 			desc = NULL;
 			ret = cookie;
 		}
+		dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
+			__func__, host->sg_len, ret, cookie, host->mrq);
 	}
-	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-		__func__, host->sg_len, ret, cookie, host->mrq);
 
 pio:
 	if (!desc) {
@@ -116,8 +116,8 @@ pio:
 			 "DMA failed: %d, falling back to PIO\n", ret);
 	}
 
-	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
-		desc, cookie, host->sg_len);
+	dev_dbg(&host->pdev->dev, "%s(): desc %p, sg[%d]\n", __func__,
+		desc, host->sg_len);
 }
 
 static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
@@ -174,9 +174,9 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 			desc = NULL;
 			ret = cookie;
 		}
+		dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
+			__func__, host->sg_len, ret, cookie, host->mrq);
 	}
-	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-		__func__, host->sg_len, ret, cookie, host->mrq);
 
 pio:
 	if (!desc) {
@@ -196,8 +196,7 @@ pio:
 			 "DMA failed: %d, falling back to PIO\n", ret);
 	}
 
-	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
-		desc, cookie);
+	dev_dbg(&host->pdev->dev, "%s(): desc %p\n", __func__, desc);
 }
 
 void tmio_mmc_start_dma(struct tmio_mmc_host *host,
-- 
2.7.4
