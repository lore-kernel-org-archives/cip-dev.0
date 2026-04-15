Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8DF419B5
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 13:21:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18779.1776259260228068217
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 06:21:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: sDmu/bVmQcOFKGJZXQU6oQ==
X-CSE-MsgGUID: RC4yEAbNTamjFEyuCuvhnQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2026 22:21:06 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.18])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0195A400A116;
	Wed, 15 Apr 2026 22:21:04 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g056: Add RSPI nodes
Date: Wed, 15 Apr 2026 13:20:55 +0000
Message-ID: <20260415132056.95570-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415132056.95570-1-ovidiu.panait.rb@renesas.com>
References: <20260415132056.95570-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 13:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22718

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4018dfc222a793f6a4fc5dfb98c883ef3782eb0f upstream.

Add nodes for the RSPI IPs found in the Renesas RZ/V2N SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251125224533.294235-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index d69b3d3d1835..5df4ef4a593b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -716,6 +716,69 @@ channel5 {
 			};
 		};
 
+		rspi0: spi@12800000 {
+			compatible = "renesas,r9a09g056-rspi",  "renesas,r9a09g057-rspi";
+			reg = <0x0 0x12800000 0x0 0x400>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 501 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_MOD 0x54>,
+				 <&cpg CPG_MOD 0x55>,
+				 <&cpg CPG_MOD 0x56>;
+			clock-names = "pclk", "pclk_sfr", "tclk";
+			resets = <&cpg 0x7b>, <&cpg 0x7c>;
+			reset-names = "presetn", "tresetn";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi1: spi@12800400 {
+			compatible = "renesas,r9a09g056-rspi",  "renesas,r9a09g057-rspi";
+			reg = <0x0 0x12800400 0x0 0x400>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 502 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 503 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_MOD 0x57>,
+				 <&cpg CPG_MOD 0x58>,
+				 <&cpg CPG_MOD 0x59>;
+			clock-names = "pclk", "pclk_sfr", "tclk";
+			resets = <&cpg 0x7d>, <&cpg 0x7e>;
+			reset-names = "presetn", "tresetn";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi2: spi@12800800 {
+			compatible = "renesas,r9a09g056-rspi",  "renesas,r9a09g057-rspi";
+			reg = <0x0 0x12800800 0x0 0x400>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 504 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 505 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_MOD 0x5a>,
+				 <&cpg CPG_MOD 0x5b>,
+				 <&cpg CPG_MOD 0x5c>;
+			clock-names = "pclk", "pclk_sfr", "tclk";
+			resets = <&cpg 0x7f>, <&cpg 0x80>;
+			reset-names = "presetn", "tresetn";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@14400400 {
 			compatible = "renesas,riic-r9a09g056", "renesas,riic-r9a09g057";
 			reg = <0 0x14400400 0 0x400>;
-- 
2.34.1


