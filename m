Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27267EB64DD
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 17:00:45 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.1260.1689699636280886731
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 10:00:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=X5MlmCtF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202307181700334e9a59a2b124a90c06-_l_uaz@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202307181700334e9a59a2b124a90c06
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Jul 2023 19:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=qsZ+QPpQqoVZyANKgK92bhxq+9+pwXg3J/HGqG0TnME=;
 b=X5MlmCtFFxOXAUPLs4pafszMBWluouHok5A0t0idqBCHTgWOVQeRbJ+z1O59A6Z4MkRi1q
 lnad9yDyV6jzmRE3RXbqKVeIH9aq38vom1caAqwd2+p3Lq+tYAs4MM9FT8VQccOHV3eMsLRy
 0YNJRguWmo3PqMghIpsR9QVZVPuLU=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 5.10.y-cip 2/2] watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
Date: Tue, 18 Jul 2023 19:00:32 +0200
Message-Id: <c2cea9e3a5f1558794c6093304e3c42557124257.1689699632.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1689699632.git.jan.kiszka@siemens.com>
References: <cover.1689699632.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 17:00:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12411

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Commit ef9b7bf52c2f47f0a9bf988543c577b92c92d15e upstream.

Daniel reported that the commit 1ae3e78c0820 ("watchdog: iTCO_wdt: No
need to stop the timer in probe") makes QEMU implementation of the iTCO
watchdog not to trigger reboot anymore when NO_REBOOT flag is initially
cleared using this option (in QEMU command line):

  -global ICH9-LPC.noreboot=false

The problem with the commit is that it left the unconditional setting of
NO_REBOOT that is not cleared anymore when the kernel keeps pinging the
watchdog (as opposed to the previous code that called iTCO_wdt_stop()
that cleared it).

Fix this so that we only set NO_REBOOT if the watchdog was not initially
running.

Fixes: 1ae3e78c0820 ("watchdog: iTCO_wdt: No need to stop the timer in probe")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20221028062750.45451-1-mika.westerberg@linux.intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/watchdog/iTCO_wdt.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 9048fa44897f..50c874d48860 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -426,14 +426,18 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
-static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+/* Returns true if the watchdog was running */
+static bool iTCO_wdt_set_running(struct iTCO_wdt_private *p)
 {
 	u16 val;
 
-	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is * enabled */
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled */
 	val = inw(TCO1_CNT(p));
-	if (!(val & BIT(11)))
+	if (!(val & BIT(11))) {
 		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+		return true;
+	}
+	return false;
 }
 
 /*
@@ -524,9 +528,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p->no_reboot_priv, true);
-
 	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
 		/*
 		 * Bit 13: TCO_EN -> 0
@@ -578,7 +579,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	iTCO_wdt_set_running(p);
+	if (!iTCO_wdt_set_running(p)) {
+		/*
+		 * If the watchdog was not running set NO_REBOOT now to
+		 * prevent later reboots.
+		 */
+		p->update_no_reboot_bit(p->no_reboot_priv, true);
+	}
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
-- 
2.35.3


