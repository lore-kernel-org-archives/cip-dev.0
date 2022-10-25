Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDACFA3740
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.7759.1666708897972625068
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 07:41:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,212,1661785200"; 
   d="scan'208";a="140312070"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2022 23:41:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6490843684FE;
	Tue, 25 Oct 2022 23:41:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/12] mtd: hyperbus: Make hyperbus_unregister_device() return void
Date: Tue, 25 Oct 2022 15:41:20 +0100
Message-Id: <20221025144131.1309463-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 14:41:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9822

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 0c90466a7985d39355f743e9cd2139da3e86c4d8 upstream.

The only thing that could theoretically fail in that function is
mtd_device_unregister(). However it's not supposed to fail and when
used correctly it doesn't. So wail loudly if it does anyhow.

This matches how other drivers (e.g. nand/raw/nandsim.c) use
mtd_device_unregister().

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220603210758.148493-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mtd/hyperbus/hbmc-am654.c    | 6 +++---
 drivers/mtd/hyperbus/hyperbus-core.c | 8 ++------
 drivers/mtd/hyperbus/rpc-if.c        | 5 +++--
 include/linux/mtd/hyperbus.h         | 4 +---
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index a3439b791eeb..a6161ce340d4 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -233,16 +233,16 @@ static int am654_hbmc_remove(struct platform_device *pdev)
 {
 	struct am654_hbmc_priv *priv = platform_get_drvdata(pdev);
 	struct am654_hbmc_device_priv *dev_priv = priv->hbdev.priv;
-	int ret;
 
-	ret = hyperbus_unregister_device(&priv->hbdev);
+	hyperbus_unregister_device(&priv->hbdev);
+
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
 
 	if (dev_priv->rx_chan)
 		dma_release_channel(dev_priv->rx_chan);
 
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id am654_hbmc_dt_ids[] = {
diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
index 2f9fc4e17d53..4d8047d43e48 100644
--- a/drivers/mtd/hyperbus/hyperbus-core.c
+++ b/drivers/mtd/hyperbus/hyperbus-core.c
@@ -126,16 +126,12 @@ int hyperbus_register_device(struct hyperbus_device *hbdev)
 }
 EXPORT_SYMBOL_GPL(hyperbus_register_device);
 
-int hyperbus_unregister_device(struct hyperbus_device *hbdev)
+void hyperbus_unregister_device(struct hyperbus_device *hbdev)
 {
-	int ret = 0;
-
 	if (hbdev && hbdev->mtd) {
-		ret = mtd_device_unregister(hbdev->mtd);
+		WARN_ON(mtd_device_unregister(hbdev->mtd));
 		map_destroy(hbdev->mtd);
 	}
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperbus_unregister_device);
 
diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index 6e08ec1d4f09..15a0be63ede1 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -153,11 +153,12 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 static int rpcif_hb_remove(struct platform_device *pdev)
 {
 	struct rpcif_hyperbus *hyperbus = platform_get_drvdata(pdev);
-	int error = hyperbus_unregister_device(&hyperbus->hbdev);
+
+	hyperbus_unregister_device(&hyperbus->hbdev);
 
 	rpcif_disable_rpm(&hyperbus->rpc);
 
-	return error;
+	return 0;
 }
 
 static struct platform_driver rpcif_platform_driver = {
diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
index 0ce612428aea..bb6b7121a542 100644
--- a/include/linux/mtd/hyperbus.h
+++ b/include/linux/mtd/hyperbus.h
@@ -89,9 +89,7 @@ int hyperbus_register_device(struct hyperbus_device *hbdev);
 /**
  * hyperbus_unregister_device - deregister HyperBus slave memory device
  * @hbdev: hyperbus_device to be unregistered
- *
- * Return: 0 for success, others for failure.
  */
-int hyperbus_unregister_device(struct hyperbus_device *hbdev);
+void hyperbus_unregister_device(struct hyperbus_device *hbdev);
 
 #endif /* __LINUX_MTD_HYPERBUS_H__ */
-- 
2.25.1


