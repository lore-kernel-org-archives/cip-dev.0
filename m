Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD994C4332F
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.31576.1643631550482787347
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231886"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:08 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B171D4347FEA;
	Mon, 31 Jan 2022 21:19:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/27] pinctrl: pinconf-generic: Add support for
 "output-impedance-ohms" to be extracted from DT files
Date: Mon, 31 Jan 2022 12:18:38 +0000
Message-Id: <20220131121903.8620-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7524

commit 032816fbbfafe3198bb5c71fbbe4e8e5be33b352 upstream.

Add "output-impedance-ohms" property to generic options used for DT
parsing files. This enables drivers, which use generic pin configurations,
to get the value passed to this property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20211027134509.5036-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/pinconf-generic.c       | 2 ++
 include/linux/pinctrl/pinconf-generic.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 1e225d513988..fcf261aa532e 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -46,6 +46,7 @@ static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_LOW_POWER_MODE, "pin low power", "mode", true),
 	PCONFDUMP(PIN_CONFIG_OUTPUT_ENABLE, "output enabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_OUTPUT, "pin output", "level", true),
+	PCONFDUMP(PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS, "output impedance", "ohms", true),
 	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector", true),
 	PCONFDUMP(PIN_CONFIG_SLEEP_HARDWARE_STATE, "sleep hardware state", NULL, false),
 	PCONFDUMP(PIN_CONFIG_SLEW_RATE, "slew rate", NULL, true),
@@ -179,6 +180,7 @@ static const struct pinconf_generic_params dt_params[] = {
 	{ "output-disable", PIN_CONFIG_OUTPUT_ENABLE, 0 },
 	{ "output-enable", PIN_CONFIG_OUTPUT_ENABLE, 1 },
 	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
+	{ "output-impedance-ohms", PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS, 0 },
 	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
 	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
 	{ "sleep-hardware-state", PIN_CONFIG_SLEEP_HARDWARE_STATE, 0 },
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 6aeb711f7cd1..545e598abb0f 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -90,6 +90,8 @@ struct pinctrl_map;
  * 	value on the line. Use argument 1 to indicate high level, argument 0 to
  *	indicate low level. (Please see Documentation/driver-api/pinctl.rst,
  *	section "GPIO mode pitfalls" for a discussion around this parameter.)
+ * @PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: this will configure the output impedance
+ * 	of the pin with the value passed as argument. The argument is in ohms.
  * @PIN_CONFIG_POWER_SOURCE: if the pin can select between different power
  *	supplies, the argument to this parameter (on a custom format) tells
  *	the driver which alternative power source to use.
@@ -127,6 +129,7 @@ enum pin_config_param {
 	PIN_CONFIG_LOW_POWER_MODE,
 	PIN_CONFIG_OUTPUT_ENABLE,
 	PIN_CONFIG_OUTPUT,
+	PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS,
 	PIN_CONFIG_POWER_SOURCE,
 	PIN_CONFIG_SLEEP_HARDWARE_STATE,
 	PIN_CONFIG_SLEW_RATE,
-- 
2.17.1


