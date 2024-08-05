Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52F0C52D71
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.12824.1722876257681924282
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="218711329"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AA24440213EE;
	Tue,  6 Aug 2024 01:44:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 17/30] media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
Date: Mon,  5 Aug 2024 17:43:10 +0100
Message-ID: <20240805164342.211857-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16739

commit f243df0a0be0bee39d60136a8f2d1616c63deb1c upstream.

Replace the old SET_RUNTIME_PM_OPS() helpers with its modern alternative
RUNTIME_PM_OPS(). The usage of pm_ptr and RUNTIME_PM_OPS() allows the
compiler to see where it's used but still drop the dead code. After this
we can get rid of the unnecessary '__maybe_unused' annotations on PM
functions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20240213181233.242316-2-biju.das.jz@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 33e08efa3039..3e9c43d59e29 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -833,7 +833,7 @@ static int rzg2l_csi2_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_csi2_pm_runtime_suspend(struct device *dev)
+static int rzg2l_csi2_pm_runtime_suspend(struct device *dev)
 {
 	struct rzg2l_csi2 *csi2 = dev_get_drvdata(dev);
 
@@ -842,7 +842,7 @@ static int __maybe_unused rzg2l_csi2_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_csi2_pm_runtime_resume(struct device *dev)
+static int rzg2l_csi2_pm_runtime_resume(struct device *dev)
 {
 	struct rzg2l_csi2 *csi2 = dev_get_drvdata(dev);
 
@@ -850,7 +850,8 @@ static int __maybe_unused rzg2l_csi2_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_csi2_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_csi2_pm_runtime_suspend, rzg2l_csi2_pm_runtime_resume, NULL)
+	RUNTIME_PM_OPS(rzg2l_csi2_pm_runtime_suspend,
+		       rzg2l_csi2_pm_runtime_resume, NULL)
 };
 
 static const struct of_device_id rzg2l_csi2_of_table[] = {
@@ -864,7 +865,7 @@ static struct platform_driver rzg2l_csi2_pdrv = {
 	.driver	= {
 		.name = "rzg2l-csi2",
 		.of_match_table = rzg2l_csi2_of_table,
-		.pm = &rzg2l_csi2_pm_ops,
+		.pm = pm_ptr(&rzg2l_csi2_pm_ops),
 	},
 };
 
-- 
2.43.0


