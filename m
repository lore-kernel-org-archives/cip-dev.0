Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03326C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3871.1657869794050960984
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955883"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF2B340083E1;
	Fri, 15 Jul 2022 16:23:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/24] reset: renesas: Fix Runtime PM usage
Date: Fri, 15 Jul 2022 08:22:40 +0100
Message-Id: <20220715072244.2298757-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8806

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 92c959bae2e54ba1e2540ba5f813f7752bd76be1 upstream.

If pm_runtime_resume_and_get() fails then it returns w/o the RPM usage
counter being incremented. In this case call pm_runtime_put() in
remove() will result in a usage counter imbalance. Therefore check the
return code of pm_runtime_resume_and_get() and bail out in case of error.

Fixes: bee08559701f ("reset: renesas: Add RZ/G2L usbphy control driver")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/ec24e13f-0530-b091-7a08-864577b9b3be@gmail.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index e0704fd2b533..1e8315038850 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -137,7 +137,12 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, priv);
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_resume_and_get(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0) {
+		pm_runtime_disable(&pdev->dev);
+		reset_control_assert(priv->rstc);
+		return dev_err_probe(&pdev->dev, error, "pm_runtime_resume_and_get failed");
+	}
 
 	/* put pll and phy into reset state */
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.25.1


