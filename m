Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8FEE645E
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88804.1767200431635644184
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: CTxeA0rZQOmaMw/puFpT1Q==
X-CSE-MsgGUID: MA6n/sEuSEKBArwSQqhUPA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:34 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E3BED402412E;
	Thu,  1 Jan 2026 02:00:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/17] watchdog: rzv2h: Make "oscclk" and reset controller optional
Date: Wed, 31 Dec 2025 17:00:12 +0000
Message-ID: <20251231170026.17006-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21282

commit 6229b35298af8c3cb983d866e9da1c1ad4803cc6 upstream.

Update the rzv2h_wdt driver to make the "oscclk" clock and reset
controller optional.

Use devm_clk_get_optional_prepared() to obtain the "oscclk" clock,
allowing the driver to work on platforms that do not provide this clock,
such as the RZ/T2H SoC.

Similarly, use devm_reset_control_get_optional_exclusive() to allow the
driver to function on platforms that lack a reset controller.

These changes are preparatory steps for supporting the RZ/T2H SoC, which
does not provide an "oscclk" clock or a reset controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 755067800ebb9..3c02960b65cf8 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -230,11 +230,11 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->pclk))
 		return dev_err_probe(dev, PTR_ERR(priv->pclk), "no pclk");
 
-	priv->oscclk = devm_clk_get_prepared(dev, "oscclk");
+	priv->oscclk = devm_clk_get_optional_prepared(dev, "oscclk");
 	if (IS_ERR(priv->oscclk))
 		return dev_err_probe(dev, PTR_ERR(priv->oscclk), "no oscclk");
 
-	priv->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
-- 
2.43.0


