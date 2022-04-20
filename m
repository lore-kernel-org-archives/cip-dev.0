Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA09C64ED9
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.13673.1650490486507714224
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 14:35:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,276,1643641200";
   d="scan'208";a="118607300"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2022 06:35:08 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 68D6B4108E3B;
	Thu, 21 Apr 2022 06:35:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 21/24] arm64: dts: renesas: rzg2l-smarc: Enable
 audio
Date: Wed, 20 Apr 2022 22:34:21 +0100
Message-Id: <20220420213424.27837-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8143

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e396d6103343ff95874444bd8a67f031eafe0e38 upstream.

Enable audio on RZ/G2L SMARC EVK by linking SSI0 with WM8978
audio CODEC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210921084605.16250-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi | 66 ++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 549cee1733c7..4bffd6b4c837 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -8,6 +8,19 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+/*
+ * SSI-WM8978
+ *
+ * This command is required when Playback/Capture
+ *
+ *	amixer cset name='Left Input Mixer L2 Switch' on
+ *	amixer cset name='Right Input Mixer R2 Switch' on
+ *	amixer cset name='Headphone Playback Volume' 100
+ *	amixer cset name='PCM Volume' 100%
+ *	amixer cset name='Input PGA Volume' 25
+ *
+ */
+
 /* comment the #define statement to disable SCIF2 (SER0) on PMOD1 (CN7) */
 #define PMOD1_SER0	1
 
@@ -24,6 +37,29 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	audio_mclock: audio_mclock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <11289600>;
+	};
+
+	snd_rzg2l: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&cpu_dai>;
+		simple-audio-card,frame-master = <&cpu_dai>;
+		simple-audio-card,mclk-fs = <256>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&ssi0>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&audio_mclock>;
+			sound-dai = <&wm8978>;
+		};
+	};
+
 	usb0_vbus_otg: regulator-usb0-vbus-otg {
 		compatible = "regulator-fixed";
 
@@ -43,6 +79,14 @@
 	};
 };
 
+&audio_clk1{
+	clock-frequency = <11289600>;
+};
+
+&audio_clk2{
+	clock-frequency = <12288000>;
+};
+
 &canfd {
 	pinctrl-0 = <&can0_pins &can1_pins>;
 	pinctrl-names = "default";
@@ -113,6 +157,9 @@
 };
 
 &pinctrl {
+	pinctrl-0 = <&sound_clk_pins>;
+	pinctrl-names = "default";
+
 	can0_pins: can0 {
 		pinmux = <RZG2L_PORT_PINMUX(10, 1, 2)>, /* TX */
 			 <RZG2L_PORT_PINMUX(11, 0, 2)>; /* RX */
@@ -205,6 +252,11 @@
 		};
 	};
 
+	sound_clk_pins: sound_clk {
+		pins = "AUDIO_CLK1", "AUDIO_CLK2";
+		input-enable;
+	};
+
 	spi1_pins: spi1 {
 		pinmux = <RZG2L_PORT_PINMUX(44, 0, 1)>, /* CK */
 			 <RZG2L_PORT_PINMUX(44, 1, 1)>, /* MOSI */
@@ -212,6 +264,13 @@
 			 <RZG2L_PORT_PINMUX(44, 3, 1)>; /* SSL */
 	};
 
+	ssi0_pins: ssi0 {
+		pinmux = <RZG2L_PORT_PINMUX(45, 0, 1)>, /* BCK */
+			 <RZG2L_PORT_PINMUX(45, 1, 1)>, /* RCK */
+			 <RZG2L_PORT_PINMUX(45, 2, 1)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(45, 3, 1)>; /* RXD */
+	};
+
 	usb0_pins: usb0 {
 		pinmux = <RZG2L_PORT_PINMUX(4, 0, 1)>, /* VBUS */
 			 <RZG2L_PORT_PINMUX(5, 0, 1)>, /* OVC */
@@ -267,6 +326,13 @@
 	status = "okay";
 };
 
+&ssi0 {
+	pinctrl-0 = <&ssi0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
-- 
2.17.1


