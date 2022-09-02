Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D00ECAAD5
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4758.1662111901797907608
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460985"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EC241400A11F;
	Fri,  2 Sep 2022 18:45:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/25] arm64: dts: renesas: rzg2l-smarc: Move ssi0
 and cpu sound_dai nodes from common dtsi
Date: Fri,  2 Sep 2022 10:44:17 +0100
Message-Id: <20220902094427.116227-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9441

commit c62af12c700dc435b82df207e49dac3f91ece6c6 upstream.

On RZ/G2{L,LC} SoM module, the wm8978 audio codec is connected to ssi0,
whereas on RZ/G2UL it is connected to ssi1. So move ssi0 and cpu
sound_dai nodes from common dtsi to board specific dtsi.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220429072400.23729-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts |  6 ------
 arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi   |  8 --------
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi       | 11 +++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi      | 11 +++++++++++
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index df27b63f0465..52ee1640c3c1 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -54,12 +54,6 @@ &spi1 {
 	status = "disabled";
 };
 
-&ssi0 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
 &usb2_phy0 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-names;
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
index 0e61b85efb43..3962d47b3e59 100644
--- a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
@@ -52,7 +52,6 @@ snd_rzg2l: sound {
 			    "Mic Bias", "Microphone Jack";
 
 		cpu_dai: simple-audio-card,cpu {
-			sound-dai = <&ssi0>;
 		};
 
 		codec_dai: simple-audio-card,codec {
@@ -168,13 +167,6 @@ &spi1 {
 	status = "okay";
 };
 
-&ssi0 {
-	pinctrl-0 = <&ssi0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index aadc41515093..e180a955b6ac 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -18,6 +18,10 @@ aliases {
 	};
 };
 
+&cpu_dai {
+	sound-dai = <&ssi0>;
+};
+
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
@@ -49,6 +53,13 @@ &scif2 {
 };
 #endif
 
+&ssi0 {
+	pinctrl-0 = <&ssi0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &vccq_sdhi1 {
 	gpios = <&pinctrl RZG2L_GPIO(39, 1) GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 74a844ea7537..aa170492dd2b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -60,6 +60,10 @@ &canfd {
 };
 #endif
 
+&cpu_dai {
+	sound-dai = <&ssi0>;
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
@@ -91,6 +95,13 @@ &scif1 {
 };
 #endif
 
+&ssi0 {
+	pinctrl-0 = <&ssi0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 #if (SW_RSPI_CAN)
 &spi1 {
 	/delete-property/ pinctrl-0;
-- 
2.25.1


