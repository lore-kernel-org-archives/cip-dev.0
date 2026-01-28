Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE1FD25B57
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 12:58:52 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12291.1769605124180184666
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 04:58:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 90SLkU//T5GPj0kbQj3NGA==
X-CSE-MsgGUID: jSGA8zPWQ+aNKwUyC0xPCg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jan 2026 21:58:43 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E8D74402393F;
	Wed, 28 Jan 2026 21:58:41 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix inverted reset logic in devm cleanup
Date: Wed, 28 Jan 2026 12:58:40 +0000
Message-ID: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 12:58:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21736

The devm reset callback that should undo the reset_control_deassert() done
during probe is incorrectly calling reset_control_deassert() again,
instead of reset_control_assert().

Fix this by calling reset_control_assert() and rename the callback
function accordingly.

Fixes: 8b53b0bf10a3 ("thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/G3S SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/rzg3s_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rzg3s_thermal.c b/drivers/thermal/rzg3s_thermal.c
index b2a98168e6b4..4c6e4fa13ee4 100644
--- a/drivers/thermal/rzg3s_thermal.c
+++ b/drivers/thermal/rzg3s_thermal.c
@@ -178,9 +178,9 @@ static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
 	return 0;
 }
 
-static void rzg3s_thermal_reset_deassert(void *data)
+static void rzg3s_thermal_reset_assert(void *data)
 {
-	reset_control_deassert(data);
+	reset_control_assert(data);
 }
 
 static void rzg3s_thermal_rem_hwmon_sysfs(void *data)
@@ -214,7 +214,7 @@ static int rzg3s_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(dev, rzg3s_thermal_reset_deassert, priv->rstc);
+	ret = devm_add_action_or_reset(dev, rzg3s_thermal_reset_assert, priv->rstc);
 	if (ret)
 		return ret;
 
-- 
2.51.0


