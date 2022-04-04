Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB433C47081
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.34385.1649075759683192518
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="115672005"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 65C654226B03;
	Mon,  4 Apr 2022 21:36:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/29] clocksource/drivers/renesas-ostm: Add RZ/G2L
 OSTM support
Date: Mon,  4 Apr 2022 13:35:39 +0100
Message-Id: <20220404123553.25851-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7978

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3a3e9f23c2cae907677a236fa547610ca747e6fb upstream.

RZ/G2L SoC has Generic Timer Module(a.k.a OSTM) which needs to
deassert the reset line before accessing any registers.

This patch adds an entry point for RZ/G2L so that we can deassert
the reset line in probe callback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211112184413.4391-4-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clocksource/renesas-ostm.c | 39 +++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 3d06ba66008c..21d1392637b8 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -9,6 +9,8 @@
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
 
@@ -159,6 +161,7 @@ static int __init ostm_init_clkevt(struct timer_of *to)
 
 static int __init ostm_init(struct device_node *np)
 {
+	struct reset_control *rstc;
 	struct timer_of *to;
 	int ret;
 
@@ -166,6 +169,14 @@ static int __init ostm_init(struct device_node *np)
 	if (!to)
 		return -ENOMEM;
 
+	rstc = of_reset_control_get_optional_exclusive(np, NULL);
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		goto err_free;
+	}
+
+	reset_control_deassert(rstc);
+
 	to->flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
 	if (system_clock) {
 		/*
@@ -178,7 +189,7 @@ static int __init ostm_init(struct device_node *np)
 
 	ret = timer_of_init(np, to);
 	if (ret)
-		goto err_free;
+		goto err_reset;
 
 	/*
 	 * First probed device will be used as system clocksource. Any
@@ -203,9 +214,35 @@ static int __init ostm_init(struct device_node *np)
 
 err_cleanup:
 	timer_of_cleanup(to);
+err_reset:
+	reset_control_assert(rstc);
+	reset_control_put(rstc);
 err_free:
 	kfree(to);
 	return ret;
 }
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
+
+#ifdef CONFIG_ARCH_R9A07G044
+static int __init ostm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ostm_init(dev->of_node);
+}
+
+static const struct of_device_id ostm_of_table[] = {
+	{ .compatible = "renesas,ostm", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ostm_device_driver = {
+	.driver = {
+		.name = "renesas_ostm",
+		.of_match_table = of_match_ptr(ostm_of_table),
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(ostm_device_driver, ostm_probe);
+#endif
-- 
2.17.1


