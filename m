Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A73C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:50:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.19377.1640181005005583785
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:50:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104366635"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 22:50:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8E8A9430FFE8;
	Wed, 22 Dec 2021 22:50:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/21] clk: renesas: r9a07g044: Add USB
 clocks/resets
Date: Wed, 22 Dec 2021 13:49:39 +0000
Message-Id: <20211222134951.19432-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:50:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7243

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 03fa6e4b2622035389a4beb9699551d63d130493 upstream.

Add clock/reset entries for USB PHY control, USB2.0 host and device.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210630073013.22415-5-biju.das.jz@bp.renesas.com
[geert: s/usb0_device/usb0_func]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 740355fe7d5c..016a69f80a05 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -96,6 +96,14 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x52c, 0),
 	DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
 				0x52c, 1),
+	DEF_MOD("usb0_host",	R9A07G044_USB_U2H0_HCLK, R9A07G044_CLK_P1,
+				0x578, 0),
+	DEF_MOD("usb1_host",	R9A07G044_USB_U2H1_HCLK, R9A07G044_CLK_P1,
+				0x578, 1),
+	DEF_MOD("usb0_func",	R9A07G044_USB_U2P_EXR_CPUCLK, R9A07G044_CLK_P1,
+				0x578, 2),
+	DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
+				0x578, 3),
 	DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
 				0x580, 0),
 	DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
@@ -126,6 +134,10 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_IA55_RESETN, 0x818, 0),
 	DEF_RST(R9A07G044_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A07G044_DMAC_RST_ASYNC, 0x82c, 1),
+	DEF_RST(R9A07G044_USB_U2H0_HRESETN, 0x878, 0),
+	DEF_RST(R9A07G044_USB_U2H1_HRESETN, 0x878, 1),
+	DEF_RST(R9A07G044_USB_U2P_EXL_SYSRST, 0x878, 2),
+	DEF_RST(R9A07G044_USB_PRESETN, 0x878, 3),
 	DEF_RST(R9A07G044_I2C0_MRST, 0x880, 0),
 	DEF_RST(R9A07G044_I2C1_MRST, 0x880, 1),
 	DEF_RST(R9A07G044_I2C2_MRST, 0x880, 2),
-- 
2.17.1


