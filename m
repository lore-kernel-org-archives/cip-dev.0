Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D80CC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:18:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.74928.1752488282775987838
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:18:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 5z8/b5gpR0SzGU0b17nw1Q==
X-CSE-MsgGUID: yCDELW1vQuiy5nbDsAEjnA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:18:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C09D3400D4D1;
	Mon, 14 Jul 2025 19:18:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 34/36] arm64: dts: renesas: r9a09g047: Add CANFD node
Date: Mon, 14 Jul 2025 11:16:34 +0100
Message-ID: <20250714101650.80381-35-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19520

commit 9c1d49dd0975cd91529417a70a34817e489d954b upstream.

Add CANFD node to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250320164121.193857-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 5b413d31b8cd9..bfdb03e69540b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -294,6 +294,66 @@ scif0: serial@11c01400 {
 			status = "disabled";
 		};
 
+		canfd: can@12440000 {
+			compatible = "renesas,r9a09g047-canfd";
+			reg = <0 0x12440000 0 0x40000>;
+			interrupts = <GIC_SPI 709 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 710 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 698 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 704 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 705 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 713 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 700 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 701 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 715 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "g_err", "g_recc",
+					  "ch0_err", "ch0_rec", "ch0_trx",
+					  "ch1_err", "ch1_rec", "ch1_trx",
+					  "ch2_err", "ch2_rec", "ch2_trx",
+					  "ch3_err", "ch3_rec", "ch3_trx",
+					  "ch4_err", "ch4_rec", "ch4_trx",
+					  "ch5_err", "ch5_rec", "ch5_trx";
+			clocks = <&cpg CPG_MOD 0x9c>, <&cpg CPG_MOD 0x9d>,
+				 <&cpg CPG_MOD 0x9e>;
+			clock-names = "fck", "ram_clk", "can_clk";
+			assigned-clocks = <&cpg CPG_MOD 0x9e>;
+			assigned-clock-rates = <80000000>;
+			resets = <&cpg 0xa1>, <&cpg 0xa2>;
+			reset-names = "rstp_n", "rstc_n";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+			channel1 {
+				status = "disabled";
+			};
+			channel2 {
+				status = "disabled";
+			};
+			channel3 {
+				status = "disabled";
+			};
+			channel4 {
+				status = "disabled";
+			};
+			channel5 {
+				status = "disabled";
+			};
+		};
+
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
-- 
2.43.0


