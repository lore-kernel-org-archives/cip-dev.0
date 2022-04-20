Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78828C64EC6
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.13673.1650490486507714224
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 14:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,276,1643641200";
   d="scan'208";a="118607262"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2022 06:34:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0AEB841088D8;
	Thu, 21 Apr 2022 06:34:43 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/24] ASoC: sh: rz-ssi: Check return value of
 pm_runtime_resume_and_get()
Date: Wed, 20 Apr 2022 22:34:09 +0100
Message-Id: <20220420213424.27837-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8131

From: Heiner Kallweit <hkallweit1@gmail.com>

commit f04b4fb47d83b110a5b007fb2eddea862cfeb151 upstream.

The return value of pm_runtime_resume_and_get() needs to be checked to
avoid a usage count imbalance in the error case. This fix is basically
the same as 92c959bae2e5 ("reset: renesas: Fix Runtime PM usage"),
and the last step before pm_runtime_resume_and_get() can be annotated
as __must_check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/9fed506d-b780-55cd-45a4-9bd2407c910f@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 89c7e5e4cbf6..e8ca3a90264d 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1020,7 +1020,12 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	reset_control_deassert(ssi->rstc);
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_disable(ssi->dev);
+		reset_control_assert(ssi->rstc);
+		return dev_err_probe(ssi->dev, ret, "pm_runtime_resume_and_get failed\n");
+	}
 
 	spin_lock_init(&ssi->lock);
 	dev_set_drvdata(&pdev->dev, ssi);
-- 
2.17.1


