Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D0DC54EE9
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.4658.1662111891781161312
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="133482043"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2022 18:44:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 39134400CF0E;
	Fri,  2 Sep 2022 18:44:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/25] arm64: dts: renesas: r9a07g043: Fillup the
 WDT{0,2} stub nodes
Date: Fri,  2 Sep 2022 10:44:12 +0100
Message-Id: <20220902094427.116227-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9436

commit a8352a5158ed032fa6c0d433fefc63285fdac8b0 upstream.

Fillup the WDT{0,2} stub nodes in RZ/G2UL (R9A07G043) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425170530.200921-7-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index d161600495aa..15335e9ca06b 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -694,13 +694,33 @@ hsusb: usb@11c60000 {
 		};
 
 		wdt0: watchdog@12800800 {
+			compatible = "renesas,r9a07g043-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800800 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G043_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G043_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		wdt2: watchdog@12800400 {
+			compatible = "renesas,r9a07g043-wdt",
+				     "renesas,rzg2l-wdt";
 			reg = <0 0x12800400 0 0x400>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G043_WDT2_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_WDT2_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G043_WDT2_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm0: timer@12801000 {
-- 
2.25.1


