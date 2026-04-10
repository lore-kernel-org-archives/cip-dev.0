Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D259F459FE
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.161292.1775840586520620468
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: 65WM7FWBRfmDWRaOuNoAlA==
X-CSE-MsgGUID: leuZZRUtSsWNe1kIsZ2cPg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:05 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D4116402F558;
	Sat, 11 Apr 2026 02:03:04 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 02/11] thermal: renesas: rzg3e: make reset optional
Date: Fri, 10 Apr 2026 20:02:06 +0300
Message-ID: <20260410170215.393698-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22665

commit 671d315c1c86a43128c0c30c82fe1eccc7af9901 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have a
reset line.

Prepare for them by making it optional.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20260108195223.193531-2-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index e66d73ca67527..86c10810e5bf5 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -412,7 +412,7 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 				     "Clock rate %lu Hz too low (min %u Hz)\n",
 				     clk_get_rate(clk), TSU_MIN_CLOCK_RATE);
 
-	priv->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "Failed to get/deassert reset control\n");
-- 
2.53.0


