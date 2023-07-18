Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A5C3DA41
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 17:00:45 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.1273.1689699636470875441
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 10:00:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=QsH1ZhIf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20230718170033c440f14d5d305bd94d-acmxjp@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230718170033c440f14d5d305bd94d
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Jul 2023 19:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5FkuxsMRcfIv1ilAFBKptTyXD8uPEFxY2UDWYinRYcY=;
 b=QsH1ZhIfk2ZzPqss96nog7CAJLaN/AikbFDmkwuA/2IVAipx58Bs5sRuqD5p2uJTghO2eJ
 270JPehDHf3yzOgQDQ3ByCxt7fE/tETR6T+7A4cwRAVi/AdJLzCfRXTi2TRMj6YPMDzm21uQ
 mk+a+0zJabEU39R4kJTzj+HF2/2P0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 5.10.y-cip 1/2] watchdog: iTCO_wdt: No need to stop the timer in probe
Date: Tue, 18 Jul 2023 19:00:31 +0200
Message-Id: <1ea79831ec7d755daf78e723140818492af67342.1689699632.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1689699632.git.jan.kiszka@siemens.com>
References: <cover.1689699632.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 17:00:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12412

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Commit 1ae3e78c08209ac657c59f6f7ea21bbbd7f6a1d4 upstream.

The watchdog core can handle pinging of the watchdog before userspace
opens the device. For this reason instead of stopping the timer, just
mark it as running and let the watchdog core take care of it.

Cc: Malin Jonsson <malin.jonsson@ericsson.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20210921102900.61586-1-mika.westerberg@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/watchdog/iTCO_wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index a370a185a41c..9048fa44897f 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -426,6 +426,16 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
+static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+{
+	u16 val;
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is * enabled */
+	val = inw(TCO1_CNT(p));
+	if (!(val & BIT(11)))
+		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+}
+
 /*
  *	Kernel Interfaces
  */
@@ -568,8 +578,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	/* Make sure the watchdog is not running */
-	iTCO_wdt_stop(&p->wddev);
+	iTCO_wdt_set_running(p);
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
-- 
2.35.3


