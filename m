Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3010ED64D
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 09:53:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.68319.1774605212736791872
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Mar 2026 02:53:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: DX6+t8rPQriTtMi9PhMVPA==
X-CSE-MsgGUID: k7a9xnB6Rqqo3y2NRAmAPQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Mar 2026 18:53:38 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.114])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 45926400753F;
	Fri, 27 Mar 2026 18:53:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/5] arm64: dts: renesas: r9a09g056: Add CANFD node
Date: Fri, 27 Mar 2026 09:53:26 +0000
Message-ID: <20260327095327.36412-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327095327.36412-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260327095327.36412-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 09:53:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22599

commit edd0ce2e33ce2dae0c31e3b39108d0c327b8fb2b upstream.

Add CANFD node to RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251224175204.3400062-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: fixed merge conflict]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 3bc7768ec7140..bb1a0cac30762 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -626,6 +626,66 @@ scif: serial@11c01400 {
 			status = "disabled";
 		};
 
+		canfd: can@12440000 {
+			compatible = "renesas,r9a09g056-canfd", "renesas,r9a09g047-canfd";
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
 		i2c0: i2c@14400400 {
 			compatible = "renesas,riic-r9a09g056", "renesas,riic-r9a09g057";
 			reg = <0 0x14400400 0 0x400>;
-- 
2.43.0


