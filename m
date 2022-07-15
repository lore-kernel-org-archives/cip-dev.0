Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0BC43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:39:34 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3828.1657870760365428455
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127957734"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:39:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06704421BCAC;
	Fri, 15 Jul 2022 16:39:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RESEND 5.10.y-cip 04/13] thermal/drivers/rz2gl: Add error
 check for reset_control_deassert()
Date: Fri, 15 Jul 2022 08:39:07 +0100
Message-Id: <20220715073916.2321319-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8815

commit 8ee1c0f6526ce942b7595951c7bb0165010051c2 upstream.

If reset_control_deassert() fails, then we won't be able to access
the device registers. Therefore check the return code of
reset_control_deassert() and bail out in case of error.

While at it replace the parameter "&pdev->dev" -> "dev" in
devm_reset_control_get_exclusive().

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20211208164010.4130-1-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rzg2l_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index d47d4a30cd6c..7a9cdc1f37ca 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -170,12 +170,14 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->dev = dev;
-	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
-	reset_control_deassert(priv->rstc);
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert");
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.25.1


