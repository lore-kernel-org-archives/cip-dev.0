Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A4EEE49B0
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1008.1692628695125774967
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="173473034"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CD615400754E;
	Mon, 21 Aug 2023 23:38:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/15] arm64: dts: renesas: rzg2l: Drop WDT2 nodes
Date: Mon, 21 Aug 2023 15:37:49 +0100
Message-Id: <20230821143759.227105-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12799

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c02734d6e4ceaf4cec3e5ec0aa17ca66e9bc280d upstream.

On members of the RZ/G2L family, WDT CH2 is specifically meant to check
the operation of the Cortex-M33 CPU.  Using it from a Cortex-A55 CPU
would result in unexpected behaviour.  Hence drop all WDT2 nodes and
their references from the affected SoC and SoM DTSI files.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi        | 15 ---------------
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi  |  5 -----
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi |  5 -----
 5 files changed, 55 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 2c5444cdbd9c..ca937f88406c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -816,21 +816,6 @@ wdt0: watchdog@12800800 {
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
index 7a62e33eb821..2a613b514d02 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1066,21 +1066,6 @@ wdt1: watchdog@12800c00 {
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
index 3211a39e49a9..0f485ccf7fa0 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1072,21 +1072,6 @@ wdt1: watchdog@12800c00 {
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
index c4faff092380..fbbb4f03440b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -351,8 +351,3 @@ &wdt1 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 78e6e2376b01..8a0d56872de7 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -276,8 +276,3 @@ &wdt1 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
-- 
2.25.1


