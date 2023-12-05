Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F36FC46CA0
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 20:39:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5124.1701808778034405625
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Dec 2023 12:39:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,253,1695654000"; 
   d="scan'208";a="185417452"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2023 05:39:37 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AD6B84075A4A;
	Wed,  6 Dec 2023 05:39:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/5] arm64: dts: renesas: rzg2l: Drop WDT2 nodes
Date: Tue,  5 Dec 2023 20:39:26 +0000
Message-Id: <20231205203929.444113-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Dec 2023 20:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13788

commit c02734d6e4ceaf4cec3e5ec0aa17ca66e9bc280d upstream.

On members of the RZ/G2L family, WDT CH2 is specifically meant to check
the operation of the Cortex-M33 CPU.  Using it from a Cortex-A55 CPU
would result in unexpected behaviour.  Hence drop all WDT2 nodes and
their references from the affected SoC and SoM DTSI files.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi  |  5 -----
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi |  5 -----
 5 files changed, 55 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 48abd75dff9a..ba48156febe1 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -822,21 +822,6 @@ wdt0: watchdog@12800800 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@12800400 {
-			compatible = "renesas,r9a07g043-wdt",
-				     "renesas,rzg2l-wdt";
-			reg = <0 0x12800400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G043_WDT2_PCLK>,
-				 <&cpg CPG_MOD R9A07G043_WDT2_CLK>;
-			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G043_WDT2_PRESETN>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g043-ostm",
 				     "renesas,ostm";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 06c2205cd752..393717227faf 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -947,21 +947,6 @@ wdt1: watchdog@12800c00 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@12800400 {
-			compatible = "renesas,r9a07g044-wdt",
-				     "renesas,rzg2l-wdt";
-			reg = <0 0x12800400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G044_WDT2_PCLK>,
-				 <&cpg CPG_MOD R9A07G044_WDT2_CLK>;
-			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G044_WDT2_PRESETN>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g044-ostm",
 				     "renesas,ostm";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 00a0f37f8972..2d3674bc8567 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -958,21 +958,6 @@ wdt1: watchdog@12800c00 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@12800400 {
-			compatible = "renesas,r9a07g054-wdt",
-				     "renesas,rzg2l-wdt";
-			reg = <0 0x12800400 0 0x400>;
-			clocks = <&cpg CPG_MOD R9A07G054_WDT2_PCLK>,
-				 <&cpg CPG_MOD R9A07G054_WDT2_CLK>;
-			clock-names = "pclk", "oscclk";
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "wdt", "perrout";
-			resets = <&cpg R9A07G054_WDT2_PRESETN>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g054-ostm",
 				     "renesas,ostm";
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index bee71f852d01..1bbc960a1989 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -349,8 +349,3 @@ &wdt1 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 5653aa53494d..2ad49a6fb9dc 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -281,8 +281,3 @@ &wdt1 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
-- 
2.34.1


