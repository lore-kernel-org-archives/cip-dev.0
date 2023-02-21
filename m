Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D0C61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 08:02:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.37157.1676966560634759034
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 00:02:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.97,314,1669042800"; 
   d="scan'208";a="150300339"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Feb 2023 17:02:39 +0900
Received: from localhost.localdomain (unknown [10.226.93.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D0CE841CEE49;
	Tue, 21 Feb 2023 17:02:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
Date: Tue, 21 Feb 2023 08:02:31 +0000
Message-Id: <20230221080232.24958-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
References: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 08:02:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10745

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6ba6f0f5910d5916539268c0ad55657bb8940616 upstream.

On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
reset the system.

The procedure described in the HW manual (Procedure for Activating Modules)
for activating the target module states we need to start supply of the
clock module before applying the reset signal. This patch makes sure we
follow the same procedure to clear the registers of the WDT module, fixing
the issues seen on RZ/Five SoC.

While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as it has
the same function calls.

Fixes: 4055ee81009e ("watchdog: rzg2l_wdt: Add set_timeout callback")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20221117114907.138583-2-fabrizio.castro.jz@renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 6eea0ee4af49..d217bc54b729 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -109,25 +109,23 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	pm_runtime_put(wdev->parent);
 	reset_control_reset(priv->rstc);
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
 
 static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
 {
-	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
-
 	wdev->timeout = timeout;
 
 	/*
 	 * If the watchdog is active, reset the module for updating the WDTSET
-	 * register so that it is updated with new timeout values.
+	 * register by calling rzg2l_wdt_stop() (which internally calls reset_control_reset()
+	 * to reset the module) so that it is updated with new timeout values.
 	 */
 	if (watchdog_active(wdev)) {
-		pm_runtime_put(wdev->parent);
-		reset_control_reset(priv->rstc);
+		rzg2l_wdt_stop(wdev);
 		rzg2l_wdt_start(wdev);
 	}
 
-- 
2.25.1


