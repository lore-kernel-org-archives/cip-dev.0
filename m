Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFD1D4414E
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 09:19:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9076.1765531178445809648
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 01:19:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: WzzJ1E7oQjCWKBDBpPXBbw==
X-CSE-MsgGUID: Lawq0rk4TCODxonUXD74QA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Dec 2025 18:19:42 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB4624092AA6;
	Fri, 12 Dec 2025 18:19:40 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/5] clocksource/drivers/renesas-ostm: Unconditionally enable reprobe support
Date: Fri, 12 Dec 2025 09:19:26 +0000
Message-ID: <20251212091928.22009-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212091928.22009-1-ovidiu.panait.rb@renesas.com>
References: <20251212091928.22009-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 09:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20972

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d204e391a0d83d73fc312e71fc62896c4d8bae79 upstream.

Previously, the OSTM driver's platform probe path was only enabled for
selected SoCs (e.g., RZ/G2L and RZ/V2H) due to issues on RZ/Ax (ARM32)
SoCs, which encountered IRQ conflicts like:

    /soc/timer@e803b000: used for clock events
    genirq: Flags mismatch irq 16. 00215201 (timer@e803c000) vs. 00215201 (timer@e803c000)
    Failed to request irq 16 for /soc/timer@e803c000
    renesas_ostm e803c000.timer: probe with driver renesas_ostm failed with error -16

These issues have since been resolved by commit 37385c0772a4
("clocksource/drivers/renesas-ostm: Avoid reprobe after successful early
probe"), which prevents reprobe on successfully initialized early timers.

With this fix in place, there is no longer a need to restrict platform
probing based on SoC-specific configs. This change unconditionally enables
reprobe support for all SoCs, simplifying the logic and avoiding the need
to update the configuration for every new Renesas SoC with OSTM.

Additionally, the `ostm_of_table` is now marked with `__maybe_unused` to
fix a build warning when `CONFIG_OF` is disabled.

RZ/A1 and RZ/A2 remain unaffected with this change.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250515182207.329176-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clocksource/renesas-ostm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 3fcbd02b2483..2089aeaae225 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -225,7 +225,6 @@ static int __init ostm_init(struct device_node *np)
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#if defined(CONFIG_ARCH_RZG2L) || defined(CONFIG_ARCH_R9A09G057)
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -233,7 +232,7 @@ static int __init ostm_probe(struct platform_device *pdev)
 	return ostm_init(dev->of_node);
 }
 
-static const struct of_device_id ostm_of_table[] = {
+static const struct of_device_id __maybe_unused ostm_of_table[] = {
 	{ .compatible = "renesas,ostm", },
 	{ /* sentinel */ }
 };
@@ -246,4 +245,3 @@ static struct platform_driver ostm_device_driver = {
 	},
 };
 builtin_platform_driver_probe(ostm_device_driver, ostm_probe);
-#endif
-- 
2.51.0


