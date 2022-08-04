Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F900C19F2A
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 14:27:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.5439.1659623256503574877
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 07:27:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,216,1654527600";
   d="scan'208";a="130342919"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Aug 2022 23:27:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EBF9B435166C;
	Thu,  4 Aug 2022 23:27:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip] ARM: 9093/1: drivers: firmwapsci: Register with
 kernel restart handler
Date: Thu,  4 Aug 2022 15:27:31 +0100
Message-Id: <20220804142731.569579-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 14:27:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9122

From: Guenter Roeck <linux@roeck-us.net>

commit 2bb565bbdc0358b6042e3076416c4ba32bd56bfc upstream.

Register with kernel restart handler instead of setting arm_pm_restart
directly. This enables support for replacing the PSCI restart handler
with a different handler if necessary for a specific board.

Select a priority of 129 to indicate a higher than default priority, but
keep it as low as possible since PSCI reset is known to fail on some
boards.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Currently reboot command is taking 60sec(default wdt timeout) to reboot
the system on RZ/{G2L,G2LC} platform, due to [1]

[1] https://elixir.bootlin.com/linux/v5.10.135/source/arch/arm64/kernel/process.c#L203

This patch allows to call watchdog_restart_notifier
and it restart the system immediately.
---
 drivers/firmware/psci/psci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..e0427042eb9b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -259,7 +259,8 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
+			  void *data)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -272,8 +273,15 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block psci_sys_reset_nb = {
+	.notifier_call = psci_sys_reset,
+	.priority = 129,
+};
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -440,7 +448,7 @@ static void __init psci_0_2_set_functions(void)
 
 	psci_ops.migrate_info_type = psci_migrate_info_type;
 
-	arm_pm_restart = psci_sys_reset;
+	register_restart_handler(&psci_sys_reset_nb);
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.25.1


