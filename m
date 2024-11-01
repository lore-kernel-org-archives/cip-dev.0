Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58583E6B274
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.36911.1730465904326430753
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="227643690"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:24 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D1BCC400A66A;
	Fri,  1 Nov 2024 21:58:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 18/28] media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
Date: Fri,  1 Nov 2024 12:57:36 +0000
Message-ID: <20241101125746.33222-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17152

From: Biju Das <biju.das.jz@bp.renesas.com>

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
[PL: Replaced RUNTIME_PM_OPS->SET_RUNTIME_PM_OPS]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 3f874edcabed8..88bacd12de129 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -839,7 +839,7 @@ static int rzg2l_csi2_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_csi2_pm_runtime_suspend(struct device *dev)
+static int rzg2l_csi2_pm_runtime_suspend(struct device *dev)
 {
 	struct rzg2l_csi2 *csi2 = dev_get_drvdata(dev);
 
@@ -848,7 +848,7 @@ static int __maybe_unused rzg2l_csi2_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_csi2_pm_runtime_resume(struct device *dev)
+static int rzg2l_csi2_pm_runtime_resume(struct device *dev)
 {
 	struct rzg2l_csi2 *csi2 = dev_get_drvdata(dev);
 
@@ -856,7 +856,8 @@ static int __maybe_unused rzg2l_csi2_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_csi2_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_csi2_pm_runtime_suspend, rzg2l_csi2_pm_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(rzg2l_csi2_pm_runtime_suspend,
+			   rzg2l_csi2_pm_runtime_resume, NULL)
 };
 
 static const struct of_device_id rzg2l_csi2_of_table[] = {
@@ -870,7 +871,7 @@ static struct platform_driver rzg2l_csi2_pdrv = {
 	.driver	= {
 		.name = "rzg2l-csi2",
 		.of_match_table = rzg2l_csi2_of_table,
-		.pm = &rzg2l_csi2_pm_ops,
+		.pm = pm_ptr(&rzg2l_csi2_pm_ops),
 	},
 };
 
-- 
2.43.0


