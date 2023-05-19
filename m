Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB6C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20996.1684484487405793144
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="163489785"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 May 2023 17:21:26 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E7F4B419E25B;
	Fri, 19 May 2023 17:21:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 10/23] arm64: dts: renesas: r9a09g011: Add watchdog node
Date: Fri, 19 May 2023 09:20:45 +0100
Message-Id: <20230519082058.109760-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11542

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 753a4ae153788225a30b0ee9dd18da83f1d94447 upstream.

The r9a09g011 (a.k.a. RZ/V2M) comes with two watchdog IPs,
but Linux is only allowed one.

Add a node for the watchdog allowed to Linux to the SoC
specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20221103223956.50575-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 460d58a0c304..e037e08026b6 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -145,6 +145,19 @@ uart0: serial@a4040000 {
 			status = "disabled";
 		};
 
+		wdt0: watchdog@a4050000 {
+			compatible = "renesas,r9a09g011-wdt",
+				     "renesas,rzv2m-wdt";
+			reg = <0 0xa4050000 0 0x80>;
+			clocks = <&cpg CPG_MOD R9A09G011_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A09G011_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&cpg R9A09G011_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@b6250000 {
 			compatible = "renesas,r9a09g011-pinctrl";
 			reg = <0 0xb6250000 0 0x800>;
-- 
2.25.1


