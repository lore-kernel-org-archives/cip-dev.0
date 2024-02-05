Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF0AC4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:41:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.61463.1707136900075202832
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:41:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827661"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:41:42 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C555840065B6;
	Mon,  5 Feb 2024 21:41:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/48] ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
Date: Mon,  5 Feb 2024 12:40:49 +0000
Message-Id: <20240205124135.14779-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14671

commit 38c042b59af0248a8b13f01b1a09d890997c9f6e upstream.

For half duplex channels we dont have separate interrupts for Tx and Rx
instead we have single interrupt Rt (where the signal for Rx and Tx is
muxed). To handle such a case install a handler in case we have a dma_rt
interrupt specified in the DT for the PIO mode.

Note, for backward compatibility we check if the Rx and Tx interrupts
are present first instead of checking Rt interrupt.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230217185225.43310-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 63 ++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 4901a660ffc5..ff5a650ac2b1 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -109,6 +109,7 @@ struct rz_ssi_priv {
 	int irq_int;
 	int irq_tx;
 	int irq_rx;
+	int irq_rt;
 
 	spinlock_t lock;
 
@@ -565,6 +566,17 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
 	}
 
+	if (irq == ssi->irq_rt) {
+		struct snd_pcm_substream *substream = strm->substream;
+
+		if (rz_ssi_stream_is_play(ssi, substream)) {
+			strm->transfer(ssi, &ssi->playback);
+		} else {
+			strm->transfer(ssi, &ssi->capture);
+			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -992,26 +1004,39 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
 		ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
-		if (ssi->irq_tx < 0)
-			return ssi->irq_tx;
-
-		ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
-				       &rz_ssi_interrupt, 0,
-				       dev_name(&pdev->dev), ssi);
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "irq request error (dma_tx)\n");
-
 		ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
-		if (ssi->irq_rx < 0)
-			return ssi->irq_rx;
-
-		ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
-				       &rz_ssi_interrupt, 0,
-				       dev_name(&pdev->dev), ssi);
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "irq request error (dma_rx)\n");
+		if (ssi->irq_tx == -ENXIO && ssi->irq_rx == -ENXIO) {
+			ssi->irq_rt = platform_get_irq_byname(pdev, "dma_rt");
+			if (ssi->irq_rt < 0)
+				return ssi->irq_rt;
+
+			ret = devm_request_irq(&pdev->dev, ssi->irq_rt,
+					       &rz_ssi_interrupt, 0,
+					       dev_name(&pdev->dev), ssi);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						"irq request error (dma_tx)\n");
+		} else {
+			if (ssi->irq_tx < 0)
+				return ssi->irq_tx;
+
+			if (ssi->irq_rx < 0)
+				return ssi->irq_rx;
+
+			ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
+					       &rz_ssi_interrupt, 0,
+					       dev_name(&pdev->dev), ssi);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						"irq request error (dma_tx)\n");
+
+			ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
+					       &rz_ssi_interrupt, 0,
+					       dev_name(&pdev->dev), ssi);
+			if (ret < 0)
+				return dev_err_probe(&pdev->dev, ret,
+						"irq request error (dma_rx)\n");
+		}
 	}
 
 	ssi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-- 
2.34.1


