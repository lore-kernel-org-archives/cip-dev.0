Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DCD4415A
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 09:20:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9108.1765531210556916680
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 01:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: tXAhxeU3TM6TarvVKg8oRg==
X-CSE-MsgGUID: vay1XHtYTZKm1FfKU3fveA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 Dec 2025 18:20:14 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A4C0B401BC17;
	Fri, 12 Dec 2025 18:20:13 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
Date: Fri, 12 Dec 2025 09:19:58 +0000
Message-ID: <20251212091959.22073-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212091959.22073-1-ovidiu.panait.rb@renesas.com>
References: <20251212091959.22073-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 09:20:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20979

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 03625d9b7e8545f0699134caf9cba384c1b11bd8 upstream.

Add OSTM0-OSTM7 nodes to RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514101528.41663-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 90964bd864cc..64420fbdf959 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -177,6 +177,86 @@ sys: system-controller@10430000 {
 			resets = <&cpg 0x30>;
 		};
 
+		ostm0: timer@11800000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x11800000 0x0 0x1000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x43>;
+			resets = <&cpg 0x6d>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm1: timer@11801000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x11801000 0x0 0x1000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x44>;
+			resets = <&cpg 0x6e>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm2: timer@14000000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x14000000 0x0 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x45>;
+			resets = <&cpg 0x6f>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm3: timer@14001000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x14001000 0x0 0x1000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x46>;
+			resets = <&cpg 0x70>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm4: timer@12c00000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x12c00000 0x0 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x47>;
+			resets = <&cpg 0x71>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm5: timer@12c01000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x12c01000 0x0 0x1000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x48>;
+			resets = <&cpg 0x72>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm6: timer@12c02000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x49>;
+			resets = <&cpg 0x73>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm7: timer@12c03000 {
+			compatible = "renesas,r9a09g056-ostm", "renesas,ostm";
+			reg = <0x0 0x12c03000 0x0 0x1000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x4a>;
+			resets = <&cpg 0x74>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g056",
 				     "renesas,scif-r9a09g057";
-- 
2.51.0


