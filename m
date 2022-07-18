Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224FDC43334
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 09:25:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.25202.1658136274779570356
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:25:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800";
   d="scan'208";a="128219459"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2022 18:24:59 +0900
Received: from biju-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DCD424007548;
	Mon, 18 Jul 2022 18:24:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 5.10.y-cip 12/12] watchdog: rzg2l_wdt: Add set_timeout
 callback
Date: Mon, 18 Jul 2022 10:24:30 +0100
Message-Id: <20220718092430.382889-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 09:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8858

commit 4055ee81009e606e830af1acd9e2e35a36249713 upstream.

This patch adds support for set_timeout callback.

Once WDT is started, the WDT cycle setting register(WDTSET) can be updated
only after issuing a module reset. Otherwise, it will ignore the writes
and will hold the previous value. This patch updates the WDTSET register
if it is active.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220225175320.11041-8-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 4e7107655cc2..6eea0ee4af49 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -115,6 +115,25 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 	return 0;
 }
 
+static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
+{
+	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	wdev->timeout = timeout;
+
+	/*
+	 * If the watchdog is active, reset the module for updating the WDTSET
+	 * register so that it is updated with new timeout values.
+	 */
+	if (watchdog_active(wdev)) {
+		pm_runtime_put(wdev->parent);
+		reset_control_reset(priv->rstc);
+		rzg2l_wdt_start(wdev);
+	}
+
+	return 0;
+}
+
 static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 			     unsigned long action, void *data)
 {
@@ -151,6 +170,7 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
 	.start = rzg2l_wdt_start,
 	.stop = rzg2l_wdt_stop,
 	.ping = rzg2l_wdt_ping,
+	.set_timeout = rzg2l_wdt_set_timeout,
 	.restart = rzg2l_wdt_restart,
 };
 
-- 
2.25.1


