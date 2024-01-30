Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3136CC47DA9
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 16:16:26 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.19.1706631361058182438
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 08:16:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="192260001"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2024 01:16:16 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 26F084003EC2;
	Wed, 31 Jan 2024 01:16:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 9/9] arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
Date: Tue, 30 Jan 2024 16:15:55 +0000
Message-Id: <20240130161555.85042-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 16:16:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14510

commit b9a0be2054964026aa58966ce9724b672f210835 upstream.

Move RZ/G2UL SoC specific parts to r9a07g043u.dtsi so that
r9a07g043.dtsi can be shared with RZ/Five (RISC-V SoC).

Below are the changes due to which SoC specific parts are moved to
r9a07g043u.dtsi:
  - RZ/G2UL has Cortex-A55 (ARM64) whereas RZ/Five has AX45MP (RISC-V),
  - RZ/G2UL has GICv3 as interrupt controller whereas RZ/Five has PLIC,
  - RZ/G2UL has interrupts for SYSC block whereas interrupts are missing
    for SYSC block on RZ/Five,
  - RZ/G2UL has armv8-timer whereas RZ/Five has riscv-timer,
  - RZ/G2UL has PSCI whereas RZ/Five have OpenSBI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20221025220629.79321-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 54 +------------------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 60 +++++++++++++++++++++
 2 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index ca937f88406c2..5f534db54d1c5 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2UL SoC
+ * Device Tree Source for the RZ/Five and RZ/G2UL SoCs
  *
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
@@ -68,36 +68,8 @@ opp-1000000000 {
 		};
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a55";
-			reg = <0>;
-			device_type = "cpu";
-			#cooling-cells = <2>;
-			next-level-cache = <&L3_CA55>;
-			enable-method = "psci";
-			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
-			operating-points-v2 = <&cluster0_opp>;
-		};
-
-		L3_CA55: cache-controller-0 {
-			compatible = "cache";
-			cache-unified;
-			cache-size = <0x40000>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-1.0", "arm,psci-0.2";
-		method = "smc";
-	};
-
 	soc: soc {
 		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -545,12 +517,6 @@ cpg: clock-controller@11010000 {
 		sysc: system-controller@11020000 {
 			compatible = "renesas,r9a07g043-sysc";
 			reg = <0 0x11020000 0 0x10000>;
-			interrupts = <SOC_PERIPHERAL_IRQ(42) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(43) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(44) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(45) IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "lpm_int", "ca55stbydone_int",
-					  "cm33stbyr_int", "ca55_deny";
 			status = "disabled";
 		};
 
@@ -605,16 +571,6 @@ dmac: dma-controller@11820000 {
 			dma-channels = <16>;
 		};
 
-		gic: interrupt-controller@11900000 {
-			compatible = "arm,gic-v3";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x0 0x11900000 0 0x40000>,
-			      <0x0 0x11940000 0 0x60000>;
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
-		};
-
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g043",
 				     "renesas,rcar-gen3-sdhi";
@@ -880,12 +836,4 @@ target: trip-point {
 			};
 		};
 	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 96f935bc2d4d1..b8bf06b512351 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -10,3 +10,63 @@
 #define SOC_PERIPHERAL_IRQ(nr)		GIC_SPI nr
 
 #include "r9a07g043.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			reg = <0>;
+			device_type = "cpu";
+			#cooling-cells = <2>;
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x40000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
+
+&soc {
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller@11900000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0x11900000 0 0x40000>,
+		      <0x0 0x11940000 0 0x60000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&sysc {
+	interrupts = <SOC_PERIPHERAL_IRQ(42) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(43) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(44) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(45) IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "lpm_int", "ca55stbydone_int",
+			  "cm33stbyr_int", "ca55_deny";
+};
-- 
2.34.1


