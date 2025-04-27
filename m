Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CA4C369D5
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:17:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.32202.1745781374770803894
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:16:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: xwipPd2gTKupFjF0EXZGNg==
X-CSE-MsgGUID: aH9erB6pSTSEAJWrUs5l1w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Apr 2025 04:16:14 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9FDCA4075A42;
	Mon, 28 Apr 2025 04:16:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 11/16] arm64: dts: renesas: r9a09g057: Add SDHI0-SDHI2 nodes
Date: Sun, 27 Apr 2025 20:15:43 +0100
Message-ID: <20250427191548.130118-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18662

commit 2cc5322acdb4b170cfc8ba8775198e1b8915dc82 upstream.

Add SDHI0-SDHI2 nodes to RZ/V2H(P) ("R9A09G057") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828124134.188864-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index b1017efdc2425..9f6939a4e40ff 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -420,6 +420,45 @@ gic: interrupt-controller@14900000 {
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
+
+		sdhi0: mmc@15c00000  {
+			compatible = "renesas,sdhi-r9a09g057";
+			reg = <0x0 0x15c00000 0 0x10000>;
+			interrupts = <GIC_SPI 735 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 736 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xa3>, <&cpg CPG_MOD 0xa5>,
+				 <&cpg CPG_MOD 0xa4>, <&cpg CPG_MOD 0xa6>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg 0xa7>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi1: mmc@15c10000 {
+			compatible = "renesas,sdhi-r9a09g057";
+			reg = <0x0 0x15c10000 0 0x10000>;
+			interrupts = <GIC_SPI 737 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 738 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xa7>, <&cpg CPG_MOD 0xa9>,
+				 <&cpg CPG_MOD 0xa8>, <&cpg CPG_MOD 0xaa>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg 0xa8>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi2: mmc@15c20000 {
+			compatible = "renesas,sdhi-r9a09g057";
+			reg = <0x0 0x15c20000 0 0x10000>;
+			interrupts = <GIC_SPI 739 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 740 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xab>, <&cpg CPG_MOD 0xad>,
+				 <&cpg CPG_MOD 0xac>, <&cpg CPG_MOD 0xae>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg 0xa9>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.43.0


