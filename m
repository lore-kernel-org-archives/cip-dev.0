Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF06D59F51
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 21:39:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4864.1765575536648134352
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 13:38:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: XGH9+aHdSuiWVV0GwwniSQ==
X-CSE-MsgGUID: 7/tloluzRzSTs4LES8CT0A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Dec 2025 06:38:59 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 425F9475F1E5;
	Sat, 13 Dec 2025 06:38:57 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/4] arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
Date: Fri, 12 Dec 2025 21:38:42 +0000
Message-ID: <20251212213843.24018-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 21:39:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21002

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7db958983c8dd14d65efdf64dd9cdcd9ce2ad2c6 upstream.

Add WDT0-WDT3 nodes to RZ/V2N ("R9A09G056") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514101528.41663-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 64420fbdf959..068f966d571c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -257,6 +257,46 @@ ostm7: timer@12c03000 {
 			status = "disabled";
 		};
 
+		wdt0: watchdog@11c00400 {
+			compatible = "renesas,r9a09g056-wdt", "renesas,r9a09g057-wdt";
+			reg = <0 0x11c00400 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x75>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@14400000 {
+			compatible = "renesas,r9a09g056-wdt", "renesas,r9a09g057-wdt";
+			reg = <0 0x14400000 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x4d>, <&cpg CPG_MOD 0x4e>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x76>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt2: watchdog@13000000 {
+			compatible = "renesas,r9a09g056-wdt", "renesas,r9a09g057-wdt";
+			reg = <0 0x13000000 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x4f>, <&cpg CPG_MOD 0x50>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x77>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt3: watchdog@13000400 {
+			compatible = "renesas,r9a09g056-wdt", "renesas,r9a09g057-wdt";
+			reg = <0 0x13000400 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x51>, <&cpg CPG_MOD 0x52>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x78>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g056",
 				     "renesas,scif-r9a09g057";
-- 
2.51.0


