Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B30C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:34 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.3716.1657869809418608409
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="126267466"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B111540138EB;
	Fri, 15 Jul 2022 16:23:26 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/24] ASoC: sh: rz-ssi: Release the DMA channels
 in rz_ssi_probe() error path
Date: Fri, 15 Jul 2022 08:22:36 +0100
Message-Id: <20220715072244.2298757-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8802

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 767e6f26204d3f5406630e86b720d01818b8616d upstream.

DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were
never released in the error path apart from one place. This patch fixes
this issue by calling rz_ssi_release_dma_channels() in the error path.

Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220426074922.13319-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index caeb236b8372..ae57c7aa580e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -976,14 +976,18 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
-	if (ssi->irq_int < 0)
+	if (ssi->irq_int < 0) {
+		rz_ssi_release_dma_channels(ssi);
 		return ssi->irq_int;
+	}
 
 	ret = devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
 			       0, dev_name(&pdev->dev), ssi);
-	if (ret < 0)
+	if (ret < 0) {
+		rz_ssi_release_dma_channels(ssi);
 		return dev_err_probe(&pdev->dev, ret,
 				     "irq request error (int_req)\n");
+	}
 
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
@@ -1011,13 +1015,16 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(ssi->rstc))
+	if (IS_ERR(ssi->rstc)) {
+		rz_ssi_release_dma_channels(ssi);
 		return PTR_ERR(ssi->rstc);
+	}
 
 	reset_control_deassert(ssi->rstc);
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
+		rz_ssi_release_dma_channels(ssi);
 		pm_runtime_disable(ssi->dev);
 		reset_control_assert(ssi->rstc);
 		return dev_err_probe(ssi->dev, ret, "pm_runtime_resume_and_get failed\n");
-- 
2.25.1


