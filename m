Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA96BC19F29
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.169.1659545650200364617
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="130216130"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:12 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2A4FB40B100C;
	Thu,  4 Aug 2022 01:54:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/13] arm64: dts: renesas: Align GPIO hog names
 with dtschema
Date: Wed,  3 Aug 2022 17:53:49 +0100
Message-Id: <20220803165358.2156150-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9074

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 48d8ee5b831ec8b6dbe3b4313fed0adcd752e20b upstream.

Dtschema expects GPIO hogs to end with a "hog" suffix.
Also, the convention for node names is to use hyphens, not underscores.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/baee4b9980576ffbab24122fce7147c9cbc2ea59.1645705998.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi       | 2 +-
 arch/arm64/boot/dts/renesas/hihope-common.dtsi            | 2 +-
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi      | 2 +-
 arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts | 2 +-
 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts         | 4 ++--
 arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi  | 4 ++--
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
index 929c7910c68d..b6b6d085600a 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
@@ -77,7 +77,7 @@ &extalr_clk {
 };
 
 &gpio6 {
-	usb_hub_reset {
+	usb-hub-reset-hog {
 		gpio-hog;
 		gpios = <10 GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index e8bf6f0c4c40..18f01dbb25f5 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -140,7 +140,7 @@ &extalr_clk {
 };
 
 &gpio6 {
-	usb1-reset {
+	usb1-reset-hog {
 		gpio-hog;
 		gpios = <10 GPIO_ACTIVE_LOW>;
 		output-low;
diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi
index 40c5e8d6d841..d66d17e34694 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi
@@ -20,7 +20,7 @@ &gpio1 {
 	 * When GP1_20 is LOW LVDS0 is connected to the LVDS connector
 	 * When GP1_20 is HIGH LVDS0 is connected to the LT8918L
 	 */
-	lvds-connector-en-gpio {
+	lvds-connector-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts
index a7b27d09f6c2..c1812d1ef06a 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts
@@ -68,7 +68,7 @@ &gpio0 {
 	 * When GP0_17 is low LVDS[01] are connected to the LVDS connector
 	 * When GP0_17 is high LVDS[01] are connected to the LT8918L
 	 */
-	lvds-connector-en-gpio{
+	lvds-connector-en-hog {
 		gpio-hog;
 		gpios = <17 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
index 49d141db53f7..fc334b4c2aa4 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
@@ -18,8 +18,8 @@ / {
 };
 
 &pinctrl {
-	/delete-node/ can0-stb;
-	/delete-node/ can1-stb;
+	/delete-node/ can0-stb-hog;
+	/delete-node/ can1-stb-hog;
 	/delete-node/ gpio-sd0-pwr-en-hog;
 	/delete-node/ sd0-dev-sel-hog;
 	/delete-node/ sd1-pwr-en-hog;
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
index 2ef217445f72..9085d8c76ce1 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
@@ -18,7 +18,7 @@ can0_pins: can0 {
 	};
 
 	/* SW7 should be at position 2->3 so that GPIO8_CAN0_STB line is activated */
-	can0-stb {
+	can0-stb-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(42, 2) GPIO_ACTIVE_HIGH>;
 		output-low;
@@ -31,7 +31,7 @@ can1_pins: can1 {
 	};
 
 	/* SW8 should be at position 2->3 so that GPIO9_CAN1_STB line is activated */
-	can1-stb {
+	can1-stb-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(42, 3) GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
index bff56d696936..37ff2091582e 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
@@ -34,7 +34,7 @@ scif1_pins: scif1 {
 
 #if SW_RSPI_CAN
 	/* SW8 should be at position 2->3 so that GPIO9_CAN1_STB line is activated */
-	can1-stb {
+	can1-stb-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(44, 3) GPIO_ACTIVE_HIGH>;
 		output-low;
-- 
2.25.1


