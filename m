Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A54AC3F6B0
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.14837.1660653273153913362
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665750"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D2671402D0A4;
	Tue, 16 Aug 2022 21:34:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/31] arm64: dts: renesas: r9a07g054: Fillup the
 WDT{0,1,2} stub nodes
Date: Tue, 16 Aug 2022 13:34:00 +0100
Message-Id: <20220816123406.27553-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9244

commit f35a868bcf95c066a00dcae9e7ee42d85eaf05b2 upstream.

Fillup the WDT{0,1,2} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220227203744.18355-9-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 50cb2f0e6e73..a3623e70f02c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -614,18 +614,48 @@
 		};
 
 		wdt0: watchdog@12800800 {
+			compatible = "renesas,r9a07g054-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800800 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G054_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		wdt1: watchdog@12800c00 {
+			compatible = "renesas,r9a07g054-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800C00 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_WDT1_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_WDT1_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G054_WDT1_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		wdt2: watchdog@12800400 {
+			compatible = "renesas,r9a07g054-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800400 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_WDT2_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_WDT2_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G054_WDT2_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm0: timer@12801000 {
-- 
2.17.1


