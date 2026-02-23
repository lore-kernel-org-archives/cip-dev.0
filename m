Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D4E98E17
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 10:27:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32568.1771842464915232283
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 02:27:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 0OiuJUKZRR+4i86nkERKfQ==
X-CSE-MsgGUID: IsCe0hqkR7iAiuXnq47ncg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Feb 2026 19:27:46 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E82AB401A659;
	Mon, 23 Feb 2026 19:27:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/4] arm64: dts: renesas: r9a09g056: Add Mali-G31 GPU node
Date: Mon, 23 Feb 2026 10:27:37 +0000
Message-ID: <20260223102738.119897-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223102738.119897-1-ovidiu.panait.rb@renesas.com>
References: <20260223102738.119897-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 10:27:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21910

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3407963b237da9532d17c421c972ad5f5ec2a536 upstream.

Add the device tree node for the ARM Mali-G31 GPU found on selected
variants of the Renesas RZ/V2N (R9A09G056) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514101528.41663-10-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index d5f198760390..10d3b9727ea5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -123,6 +123,35 @@ L3_CA55: cache-controller-0 {
 		};
 	};
 
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-630000000 {
+			opp-hz = /bits/ 64 <630000000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-315000000 {
+			opp-hz = /bits/ 64 <315000000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-157500000 {
+			opp-hz = /bits/ 64 <157500000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-78750000 {
+			opp-hz = /bits/ 64 <78750000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-19687500 {
+			opp-hz = /bits/ 64 <19687500>;
+			opp-microvolt = <800000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -529,6 +558,28 @@ i2c8: i2c@11c01000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@14850000 {
+			compatible = "renesas,r9a09g056-mali",
+				     "arm,mali-bifrost";
+			reg = <0x0 0x14850000 0x0 0x10000>;
+			interrupts = <GIC_SPI 884 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 883 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu", "event";
+			clocks = <&cpg CPG_MOD 0xf0>,
+				 <&cpg CPG_MOD 0xf1>,
+				 <&cpg CPG_MOD 0xf2>;
+			clock-names = "gpu", "bus", "bus_ace";
+			resets = <&cpg 0xdd>,
+				 <&cpg 0xde>,
+				 <&cpg 0xdf>;
+			reset-names = "rst", "axi_rst", "ace_rst";
+			power-domains = <&cpg>;
+			operating-points-v2 = <&gpu_opp_table>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@14900000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x14900000 0 0x20000>,
-- 
2.51.0


