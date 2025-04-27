Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2290DC369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:18:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.32202.1745781374770803894
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:16:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: YLgrd/zdQyKtE8bR76/r7A==
X-CSE-MsgGUID: VEC/ls1CRI249xxsRU1fGA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Apr 2025 04:16:16 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BA7814075A70;
	Mon, 28 Apr 2025 04:16:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 12/16] arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes
Date: Sun, 27 Apr 2025 20:15:44 +0100
Message-ID: <20250427191548.130118-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18663

commit 095105496e7dde554aa3dc01189779759d976c2d upstream.

Add WDT0-WDT3 nodes to RZ/V2H(P) ("R9A09G057") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828124134.188864-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 9f6939a4e40ff..1ad5a1b6917fe 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -201,6 +201,46 @@ ostm7: timer@12c03000 {
 			status = "disabled";
 		};
 
+		wdt0: watchdog@11c00400 {
+			compatible = "renesas,r9a09g057-wdt";
+			reg = <0 0x11c00400 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x75>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@14400000 {
+			compatible = "renesas,r9a09g057-wdt";
+			reg = <0 0x14400000 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x4d>, <&cpg CPG_MOD 0x4e>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x76>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt2: watchdog@13000000 {
+			compatible = "renesas,r9a09g057-wdt";
+			reg = <0 0x13000000 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x4f>, <&cpg CPG_MOD 0x50>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x77>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt3: watchdog@13000400 {
+			compatible = "renesas,r9a09g057-wdt";
+			reg = <0 0x13000400 0 0x400>;
+			clocks = <&cpg CPG_MOD 0x51>, <&cpg CPG_MOD 0x52>;
+			clock-names = "pclk", "oscclk";
+			resets = <&cpg 0x78>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g057";
 			reg = <0 0x11c01400 0 0x400>;
-- 
2.43.0


